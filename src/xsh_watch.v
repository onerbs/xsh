// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import xsh
import plu { fail }

//
// Usage: xsh_watch [<options>] [<entries>]
//
// Options:
//   -d, --del      Enable the delete mode
//   -q, --quiet    Enable the quiet mode
//

fn main() {
	mut state := xsh.get_state() or { exit(fail(err.msg)) }
	mut path := state.get_path()
	mut args := plu.get_args()

	quiet := plu.parse_flag(mut args, ['-q', '--quiet'])
	to_add, to_del := extract(args)

	if to_add.len > 0 {
		path << to_add
	}

	for it in to_del {
		if it in path {
			ix := path.index(it)
			path.delete(ix)
		}
	}

	state.set_path(path)

	if !quiet {
		println(path.join('\n'))
	}
}

fn extract(raw []string) ([]string, []string) {
	mut to_add := []string{}
	mut to_del := []string{}
	mut status := true
	for it in raw {
		if it in ['-d', '--del'] {
			status = false
			continue
		}
		if status {
			to_add << plu.real_path(it)
		} else {
			to_del << plu.real_path(it)
		}
	}
	return to_add, to_del
}
