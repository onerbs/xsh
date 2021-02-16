// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import xsh
import cmd

// Usage: abs [-r] <path>

fn main() {
	mut args := xsh.get_args()
	real := cmd.parse_flag(mut args, ['-r', '--real'])
	path := get_path(args.join(' '))
	if real {
		println(cmd.real_path(path))
	} else {
		println(cmd.abs_path(path))
	}
}

fn get_path(s string) string {
	return if s == '' { '.' } else { s }
}
