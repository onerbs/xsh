// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import doc
import plu { fail }

//
// Usage: xsh_doc <lib> [<fun>]
//

fn main() {
	args := plu.need_args(1) or { exit(fail(err.msg)) }

	lib_name := args.first()
	fun_name := if args.len > 1 { args[1] } else { '' }

	sheets := doc.get_sheets_by_name(lib_name) or { exit(fail(err.msg)) }

	if fun_name.len > 0 {
		for s in sheets {
			target := s.get_entes().find(fun_name) or { continue }
			plu.set_title(s.origin)
			println(target)
			exit(0)
		}
		exit(not_found(fun_name, lib_name))
	} else {
		for s in sheets {
			plu.set_title(s.origin)
			println(s.get_entes().map('$it').join('\n'))
		}
	}
}

fn not_found(fun string, lib string) int {
	return fail('the function "$fun" was not found in lib "$lib"')
}
