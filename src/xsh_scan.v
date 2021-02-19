// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import xsh
import cmd
import doc

// Usage: xsh_scan list [-m]

fn main() {
	mut args := xsh.need_args(1) or { exit(fatal(err)) }
	cmd_name := args[0]
	match cmd_name {
		'list' { cmd_list(mut args[1..]) }
		else { exit(fatal('unknown command: "${cmd_name}"')) }
	}
}

// cmd_list will print a list of all known libs
fn cmd_list(mut args []string) {
	minimal := cmd.parse_flag(mut args, ['-m'])

	shelve := doc.get_shelve() or { exit(fatal(err)) }
	mut result := []string{}

	for book in shelve {
		if minimal {
			result << book.books.map(doc.get_base_name)
			result << book.sheets.map(doc.get_base_name)
		} else {
			cmd.set_title(book.origin)
		}
	}

	if result.len > 0 {
		println(result.join('\n'))
	}
}

fn fatal(err string) int {
	return xsh.fail('xsh_scan: $err')
}
