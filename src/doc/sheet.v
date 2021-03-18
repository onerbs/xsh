// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import term

struct Sheet {
pub:
	origin string
	name   string
pub mut:
	functions []Function
	aliases   []Alias
}

pub fn sheet(origin string) Sheet {
	name := simple_path(origin)
	return Sheet{
		origin: origin
		name: name
	}
}

pub fn (self Sheet) peek(name string) Sheet {
	if name.len == 0 {
		return self
	}
	return Sheet{
		origin: self.origin
		name: self.name
		functions: self.functions.filter(it.name == name)
		aliases: self.aliases.filter(it.name == name)
	}
}

pub fn (self Sheet) str() string {
	bright_origin := term.bold(self.origin)
	mut result := '\n  $bright_origin\n\n'
	aliases := self.aliases.map('$it').join('\n')
	functions := self.functions.map('$it').join('\n')
	if aliases.len > 0 {
		result += aliases
		if functions.len > 0 {
			result += '\n'
		}
	}
	if functions.len > 0 {
		result += functions
	}
	return result
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
