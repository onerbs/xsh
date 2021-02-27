// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module xsh

import os
import plu

struct State {
	origin string
mut:
	path []string
}

pub fn get_state() ?State {
	xsh_home := plu.need_env('XSH_HOME') ?
	origin := os.join_path(xsh_home, 'state')
	raw := os.read_file(origin) or {
		create_state(xsh_home, origin)
	}
	path := raw.split(os.path_delimiter)
	state := State{
		origin: origin
		path: path
	}
	return state
}

pub fn (s State) get_path() []string {
	return s.path
}

pub fn (mut s State) set_path(path []string) {
	if path != s.path {
		s.path = path
		record(s.origin, '$s')
	}
}

pub fn (s State) str() string {
	return s.path.join(os.path_delimiter)
}

fn create_state(xsh_home string, origin string) string {
	def_state := os.join_path(xsh_home, 'lib')
	record(origin, def_state)
	return def_state
}

fn record(file string, data string) {
	os.write_file(file, data) or {
		eprintln('unable to write file "$file"\n$err')
	}
}
