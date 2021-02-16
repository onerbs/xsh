// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module cmd

import term

pub fn set_title(title string) {
	println('\n  ${term.bold(title)}')
}

// fixed append spaces to the end of item so the length
// match the specified metric.
pub fn fixed(item string, metro int) string {
	return item + ' '.repeat(metro - item.len)
}
