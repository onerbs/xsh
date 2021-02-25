// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module cmd

import term

// set_title prints the provided text in bold
// preceded by a new line and two spaces.
pub fn set_title(title string) {
	println('\n  ${term.bold(title)}')
}

// fixed add spaces at the end of the item
// so that the length matches the specified metric.
pub fn fixed(item string, metro int) string {
	return item + ' '.repeat(metro - item.len)
}
