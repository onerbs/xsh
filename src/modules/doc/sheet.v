// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import term

struct Sheet {
pub:
	origin string
	name   string
}

pub fn sheet(origin string) Sheet {
	name := simple_path(origin)
	return Sheet{origin, name}
}

pub fn get_sheets_by_name(name string) ?[]Sheet {
	shelve := get_shelve() ?
	return shelve.find_sheets(name)
}

// The supported forms are:
// - *bold*
// - _italic_
// - /mode/text/
// format will apply some styling to the text
[direct_array_access]
fn format(ln string) string {
	mut line := ln
	for {
		if line.count('*') > 1 {
			line = line.replace_once('*', '\e[1m')
			line = line.replace_once('*', '\e[m')
		} else if line.count('_') > 1 {
			line = line.replace_once('_', '\e[3m')
			line = line.replace_once('_', '\e[m')
		} else if line.count('/') > 2 {
			idxs := get_idxs(line)
			mode := line[idxs[0] + 1..idxs[1]]
			text := line[idxs[1] + 1..idxs[2]]
			tint := term.format(text, mode, '')
			line = line.replace('/$mode/$text/', tint)
		} else {
			break
		}
	}
	return line
}

fn get_idxs(line string) []int {
	mut idxs := []int{cap: 3}
	mut index := 0
	for c in line {
		if c == `/` {
			idxs << index
		}
		index++
	}
	return idxs
}
