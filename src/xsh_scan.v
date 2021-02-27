// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import doc
import plu { fail }

//
// Usage: xsh_scan <command>
//
// Commands:
//   list [<options>]
//
//     Options:
//       -m    Enable the minimal mode
//

fn main() {
	mut args := plu.need_args(1) or { exit(fail(err)) }
	cmd_name := args[0]
	match cmd_name {
		'list' { cmd_list(mut args[1..]) }
		else { exit(fail('unknown command: "$cmd_name"')) }
	}
}

// cmd_list will print a list of all known libs
fn cmd_list(mut args []string) {
	minimal := plu.parse_flag(mut args, ['-m'])

	shelve := doc.get_shelve() or { exit(fail(err)) }
	mut result := []string{}

	for book in shelve {
		if minimal {
			result << book.books.map(doc.simple_path)
			result << book.sheets.map(doc.simple_path)
		} else {
			plu.set_title(book.origin)
		}
	}

	if result.len > 0 {
		println(result.join('\n'))
	}
}
