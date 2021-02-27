// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import plu
import term

struct Flag {
	key string
	val string
mut:
	metro int
}

const (
	token_any = 'any'
	token_nil = 'nil'
)

fn flag(line string) Flag {
	mut arg := ''
	mut key, mut val := get_item(line, ' ) # ')
	if ': ' in val {
		arg, val = get_item(val, ': ')
	}
	key = if key == '*' {
		if arg == '' { doc.token_any } else { arg }
	} else if key == "''" {
		doc.token_nil
	} else if arg != '' {
		'$key $arg'
	} else {
		key
	}
	return Flag{
		key: key
		val: val
		metro: 0
	}
}

fn get_item(s string, x string) (string, string) {
	tmp := s.split_nth(x, 2)
	return tmp[0], tmp[1]
}

fn (f Flag) str() string {
	mut key := plu.fixed_len(f.key, f.metro)
	if f.key in [doc.token_any, doc.token_nil] {
		key = term.italic(key)
	}
	return key + f.val
}
