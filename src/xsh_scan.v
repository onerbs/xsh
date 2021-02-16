// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import xsh
import cmd
import doc

// Usage: xsh_scan list [-m] [-r] <dir>

fn main() {
	mut args := xsh.need_args(2) or { exit(fatal(err)) }
	cmd_name := args[0]
	match cmd_name {
		'list' { cmd_list(mut args[1..]) }
		else { exit(fatal('unknown command: "${cmd_name}"')) }
	}
}

// cmd_list will print a list of all known libs
fn cmd_list(mut args []string) {
	minimal := cmd.parse_flag(mut args, ['-m'])
	recursive := cmd.parse_flag(mut args, ['-r'])

	if args.len == 0 {
		exit(fatal('not enough arguments'))
	}

	book := doc.book(args[0])

	if recursive {
		if minimal {
			println(book.books.map(doc.get_base_name).join('\n'))
			println(book.sheets.map(doc.get_base_name).join('\n'))
		} else {
			println('recursive')
		}
	} else {
		if minimal {
			println(book.sheets.map(doc.get_base_name).join('\n'))
		} else {
			println('complete')
		}
	}
}

fn fatal(err string) int {
	return xsh.fail('xsh_scan: $err')
}
