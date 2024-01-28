// Copyright (c) 2021,2024 Alejandro Elí
// All rights reserved. This file is subject to the terms and conditions
// defined in the LICENSE file, which is part of this source code package

module main

import kiss
import os
import uwu
import xsh

struct App {
	args []string
	list bool
}

fn xsh_watch() !App {
	mut app := kiss.new(
		brief: 'XSH lib directories'
		version: '1.2.240127'
		with_stdin: false
	)

	// todo: `--add`, `--del` flags.

	l_flag := app.flag(
		kind: .bool
		brief: 'List the watch path'
		name: 'list'
		alias: `l`
	)

	app.parse()!

	return App{
		args: app.get_args()
		list: l_flag.bool()
	}
}

fn play() ! {
	app := xsh_watch()!
	dif := app.get_dif()

	mut state := xsh.get_state()!
	mut path := state.get_path()

	for it in dif.add {
		if it !in path {
			path << it
		}
	}
	for it in dif.del {
		ix := path.index(it)
		if ix >= 0 {
			path.delete(ix)
		}
	}
	state.set_path(path)

	if app.list {
		println(path.join_lines())
		return
	}
}

struct Dif {
mut:
	add []string
	del []string
}

fn (app App) get_dif() Dif {
	mut dif := Dif{}
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
	return dif
}

fn main() {
	play() or {
		uwu.catch(err)
	}
}
