// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import os

// simple return the file name without extension.
pub fn simple(file string) string {
	return if '.' in file { file.split('.')[0] } else { file }
}

// simple_path return the simple name of the provided path.
pub fn simple_path(path string) string {
	return simple(os.base(path))
}

fn section<T>(title string, xs []T) string {
	if xs.len == 0 {
		return ''
	}
	return '\n\n  $title:\n' + xs.map('    $it').join('\n')
}
