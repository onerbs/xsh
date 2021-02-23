// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import xsh
import cmd
import os

// Usage: table [<options>] <input>
// Usage: some_command | table [<options>] -

// Options:
//   -r <delimiter>    Define the row delimiter
//   -c <delimiter>    Define the cell delimiter

fn main() {
	mut args := xsh.need_args(1) or { exit(fatal(err)) }

	rd := cmd.parse_flag_value(mut args, ['-r'], '\n')
	cd := cmd.parse_flag_value(mut args, ['-c'], ':')

	src := if args == ['-'] { os.get_lines().join(rd) } else { args.join(' ') }
	println(cmd.table(src, rd, cd))
}

fn fatal(msg string) int {
	return xsh.fail('table: $msg')
}
