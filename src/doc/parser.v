// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import os

pub fn (mut self Sheet) parse() Sheet {
	mut tmp_fn := Function{}
	mut tmp_as := Alias{}
	mut iside_function := false
	for line in clean_file(self.origin) {
		if line.starts_with('alias') {
			parts := line.split_nth('=', 2)
			name := parts[0].split_nth(' ', 2)[1]
			alias := parts[1][1..parts[1].len - 1]
			self.aliases << Alias{
				name: name
				headline: tmp_as.headline
				alias: alias
				usage: tmp_as.usage
				notes: tmp_as.notes
			}
			tmp_as = Alias{}
		} else if line.ends_with(' () {') {
			tmp_fn = new_function(line.split_nth(' ', 2)[0])
			iside_function = true
		} else if line == '}' {
			if iside_function {
				self.functions << tmp_fn
				iside_function = false
			}
		} else if line.starts_with('#! ') {
			headline := line[3..]
			if iside_function {
				tmp_fn.headline = headline
			} else {
				tmp_as.headline = headline
			}
		} else if line.starts_with('#+ ') {
			usage := line[3..]
			if iside_function {
				tmp_fn.usage = usage
			} else {
				tmp_as.usage = usage
			}
		} else if line.starts_with('#-') {
			notes := if line.len > 2 { format(line[3..]) } else { '' }
			if iside_function {
				tmp_fn.notes << notes
			} else {
				tmp_as.notes << notes
			}
		} else if line.starts_with('#: ') {
			if iside_function {
				tmp_fn.demos << demo(tmp_fn.name, line[3..])
			}
		} else if ' ) # ' in line {
			if iside_function {
				tmp_fn.flags << flag(line)
			}
		}
	}
	return self
}

// clean_file clean the lines of the specified file
pub fn clean_file(file string) []string {
	lines := os.read_lines(file) or { return []string{} }
	return lines.map(it.trim_space()).filter(it.len > 0 && !it.starts_with('# '))
}
