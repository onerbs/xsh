// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import doc
import plu { fail }

//
// Usage: xsh_doc <lib> [<name>]
//

fn main() {
	args := plu.need_args(1) or { exit(fail(err.msg)) }
	name := if args.len > 1 { args[1] } else { '' }
	mut sheets := doc.get_sheets_by_name(args[0])
	for mut sheet in sheets {
		println(sheet.parse().peek(name))
	}
}
