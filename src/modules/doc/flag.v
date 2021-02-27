// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import plu

struct Flag {
	key    string
	val string
mut:
	metro int
}

const (
	token_any = 'any'
	token_nil = 'nil'
)

fn flag(line string) Flag {
	// todo: alternative notation (#~ ?)
	mut arg := ''
	mut key, mut val := get_item(line, ' ) # ')
	if ': ' in val {
		arg, val = get_item(val, ': ')
	}
	key = if key.ends_with('*') {
		if arg == '' { token_any } else { key.replace('*', arg) }
	} else if key == "''" {
		token_nil
	} else if arg == '' {
		key
	} else {
		'$key $arg'
	}
	return Flag{
		key: key
		val: val
		metro: 0
	}
}

// this function does not ensure x in s
fn get_item(s string, x string) (string, string) {
	tmp := s.split_nth(x, 2)
	return tmp[0], tmp[1]
}

fn (this Flag) str() string {
	// key := if __key__ in [token_any, token_nil] { term.italic(__key__) } else { __key__ }
	return plu.fixed_len(this.key, this.metro) + this.val
}
