// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import plu

struct Demo {
	key string
	val string
mut:
	metro int
}

const (
	token_arrow = ' -> '
	token_this  = '@this'
	token_fmt   = ' @fmt'
)

fn demo(name string, line string) Demo {
	mut key, mut val := if doc.token_arrow in line {
		tmp := line.split_nth(doc.token_arrow, 2)
		tmp[0], tmp[1]
	} else {
		line, ''
	}
	if doc.token_this in key {
		key = key.replace(doc.token_this, name)
	} else {
		key = '$name $key'
	}
	if val.ends_with(doc.token_fmt) {
		val = format(val[..val.len - doc.token_fmt.len])
	}
	return Demo{
		key: key
		val: val
		metro: 0
	}
}

fn (d Demo) str() string {
	if d.val.len == 0 {
		return d.key
	}
	return plu.fixed_len(d.key, d.metro) + '# Prints: $d.val'
}
