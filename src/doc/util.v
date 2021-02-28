// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import os

// simple return the file name without extension.
pub fn simple(file string) string {
	if !('.' in file) {
		return file
	}
	parts := file.split('.')
	return parts[0..parts.len - 1].join('.')
}

// simple_path return the basename of the provided path without extension.
pub fn simple_path(path string) string {
	return simple(os.base(path))
}
