// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import cmd
import xsh
import doc

// Usage: xsh_doc <lib> [<fun>]

fn main() {
	args := xsh.need_args(1) or { exit(fatal(err)) }

	lib_name := args.first()
	fun_name := if args.len > 1 { args[1] } else { '' }

	libs := doc.get_sheets_by_name(lib_name) or { exit(fatal(err)) }

	if fun_name.len > 0 {
		for lib in libs {
			target := lib.get_entes().find(fun_name) or { continue }
			cmd.set_title(lib.origin)
			println(target)
			exit(0)
		}
		exit(fatal(not_found(fun_name, lib_name)))
	} else {
		for lib in libs {
			cmd.set_title(lib.origin)
			println(lib.get_entes().map('$it').join('\n'))
		}
	}
}

fn not_found(fun string, lib string) string {
	return 'the function "$fun" was not found in lib "$lib"'
}

fn fatal(msg string) int {
	return xsh.fail('xsh_doc: $msg')
}
