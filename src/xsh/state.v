// Copyright (c) 2021,2024 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module xsh

import os
import uwu
import uwu.fs

@[noinit]
pub struct State {
	origin string
mut:
	path []string
}

const libdir = os.join_path(xsh.home, 'lib')
const origin = os.join_path(xsh.home, 'state')

pub fn get_state() !State {
	if raw := fs.read_text(xsh.origin) {
		return State{
			origin: xsh.origin
			path: raw.split(os.path_delimiter)
		}
	} else {
		mut state := State{
			origin: xsh.origin
		}
		state.set_path([xsh.libdir])
		return state
	}
}

@[inline]
pub fn (self State) get_path() []string {
	return self.path
}

@[inline]
pub fn (mut self State) set_path(path []string) {
	if path != self.path {
		self.path = path
		fs.write_text(self.origin, '${self}') or {
			log.fail(err.msg())
		}
	}
}

pub fn (self State) str() string {
	return self.path.join(os.path_delimiter)
}
