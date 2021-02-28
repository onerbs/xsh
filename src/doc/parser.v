// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import os

pub fn (s Sheet) get_entes() []Ente {
	mut entes := []Ente{}
	mut current := Ente{}
	mut ongoing := false
	lines := clean_file(s.origin)
	for line in lines {
		if ' () {' in line {
			current = ente(line.split(' ')[0])
			ongoing = true
		}
		if line == '}' {
			if ongoing {
				entes << current
				current = &Ente{}
				ongoing = false
			}
		} else if line.starts_with('#! ') {
			if ongoing {
				current.headline = ' — ${line[3..]}'
			}
		} else if line.starts_with('#+ ') {
			if ongoing {
				current.usage = line[3..]
			}
		} else if line.starts_with('#-') {
			if ongoing {
				current.notes << if line.len > 2 { format(line[3..]) } else { '' }
			}
		} else if line.starts_with('#: ') {
			if ongoing {
				current.demos << demo(current.name, line[3..])
			}
		} else if ' ) # ' in line {
			if ongoing {
				current.flags << flag(line)
			}
		}
	}
	return entes
}

// clean_file clean the lines of the specified file
pub fn clean_file(file string) []string {
	lines := os.read_lines(file) or { return []string{} }
	return lines.map(it.trim_space()).filter(it.len > 0 && !it.starts_with('# '))
}
