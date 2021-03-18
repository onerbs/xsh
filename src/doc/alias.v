// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import term

pub struct Alias {
pub mut:
	name string
mut:
	headline string
	alias    string
	usage    string
	notes    []string
}

pub fn (self Alias) str() string {
	fmt_name := term.green(self.name)
	mut result := '  $fmt_name'
	if self.headline.len > 0 {
		result += ' — $self.headline'
	}
	fmt_alias := term.gray(self.alias)
	result += '\n  $fmt_alias $self.usage'
	result += section('Notes', self.notes)
	return '$result\n'
}
