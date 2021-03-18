// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import term
import arrays

pub struct Function {
pub:
	name string
mut:
	headline string
	usage    string
	flags    []Flag
	notes    []string
	demos    []Demo
}

fn new_function(name string) Function {
	return Function{
		name: name
		headline: ''
		usage: ''
		flags: []Flag{}
		notes: []string{}
		demos: []Demo{}
	}
}

fn (mut self Function) str() string {
	self.update_metro()
	bright_name := term.yellow(self.name)
	mut result := '  $bright_name'
	if self.headline.len > 0 {
		result += ' — $self.headline'
	}
	result += '\n  Usage: $self.name $self.usage'
	result += section('Options', self.flags)
	result += section('Notes', self.notes)
	result += section('Examples', self.demos)
	return '$result\n'
}

fn (mut self Function) update_metro() {
	if self.flags.len > 0 {
		metro := arrays.max(self.flags.map(it.key.len)) + 4
		set_metro(mut self.flags, metro)
	}
	if self.demos.len > 0 {
		metro := arrays.max(self.demos.map(it.key.len)) + 4
		set_metro(mut self.demos, metro)
	}
}

fn set_metro<T>(mut items []T, metro int) {
	for mut x in items {
		x.metro = metro
	}
}
