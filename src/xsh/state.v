// Copyright (c) 2021,2024 Alejandro Elí
// All rights reserved. This file is subject to the terms and conditions
// defined in the LICENSE file, which is part of this source code package

module xsh

import os
import uwu
import uwu.log

@[noinit]
pub struct State {
mut:
	path []string
}

const state_file = os.join_path(xsh.home, 'state')

pub fn get_state() !State {
	if buf := uwu.read_file(xsh.state_file) {
		path := buf.bytestr().split(os.path_delimiter)
		return State{path}
	} else {
		mut state := State{}
		state.set_path([
			os.join_path(xsh.home, 'lib')
		])
		return state
	}
}

@[inline]
pub fn (self State) get_path() []string {
	return self.path
}

pub fn (mut self State) set_path(path []string) {
	if path != self.path {
		self.path = path
		dat := self.path.join(os.path_delimiter).bytes()
		uwu.write_file(xsh.state_file, dat) or {
			log.fail(err.msg())
		}
	}
}
