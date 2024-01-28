// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import kiss
import uwu
import xsh

//
// Usage: xsh_watch [<options>] [<entries>]
//
// Options:
//   -d, --del      Enable the delete mode
//   -q, --quiet    Enable the quiet mode
//

struct Diff {
mut:
	add []string
	del []string
}

struct Context {
	args []string
	quiet bool
}

fn xsh_watch() !Context {
	mut app := kiss.new(
		brief: ''
	)

	q_flag := app.flag(
		kind: .bool
		brief: 'Enable quiet mode'
		name: 'quiet'
		alias: `q`
	)

	app.parse()!

	return Context{
		args: app.get_args()
		quiet: q_flag.bool()
	}
}

fn play() ! {
	mut state := xsh.get_state()!
	mut path := state.get_path()

	app := xsh_watch()
	diff := app.get_diff()

	for it in diff.add {
		if it !in path {
			path << it
		}
	}
	for it in diff.del {
		ix := path.index(it)
		if ix >= 0 {
			path.delete(ix)
		}
	}

	state.set_path(path)

	if !app.quiet {
		println('xsh_path:')
		println(path.map('\t${it}').join_lines())
	}
}

fn (app Context) get_diff() Diff {
	mut diff := Diff{}
	mut buf := &dif.add
	for it in app.args {
		if it in ['-a', '--add'] {
			buf = &dif.add
		} else if it in ['-d', '--del'] {
			buf = &dif.del
		} else {
			buf << os.abs_path(it)
		}
	}
	return diff
}
