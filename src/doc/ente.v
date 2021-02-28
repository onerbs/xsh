// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import term
import arrays

struct Ente {
	internal bool
pub:
	name string
mut:
	headline string
	usage    string
	flags    []Flag
	notes    []string
	demos    []Demo
}

// find will find the ente with the specified name
pub fn (es []Ente) find(name string) ?Ente {
	for e in es {
		if e.name == name {
			return e
		}
	}
	return none
}

fn ente(name string) &Ente {
	return &Ente{
		internal: '::' in name
		name: name
		headline: ''
		usage: ''
		flags: []Flag{}
		notes: []string{}
		demos: []Demo{}
	}
}

fn (mut e Ente) str() string {
	e.update_metro()
	bright_name := term.yellow(e.name)
	if e.internal {
		return '  $bright_name (internal)\n\n'
	}
	mut result := '  $bright_name$e.headline'
	result += '\n  Usage: $e.name $e.usage'
	result += section('Options', e.flags)
	result += section('Notes', e.notes)
	result += section('Examples', e.demos)
	return '$result\n'
}

fn section<T>(title string, xs []T) string {
	if xs.len == 0 {
		return ''
	}
	return '\n\n  $title:\n' + xs.map('    $it').join('\n')
}

fn (mut e Ente) update_metro() {
	if e.flags.len > 0 {
		metro := arrays.max(e.flags.map(it.key.len)) + 4
		e.flags = with_metro(e.flags, metro)
	}
	if e.demos.len > 0 {
		metro := arrays.max(e.demos.map(it.key.len)) + 4
		e.demos = with_metro(e.demos, metro)
	}
}

fn with_metro<T>(xs []T, metro int) []T {
	mut res := xs.clone()
	for mut x in res {
		x.metro = metro
	}
	return res
}
