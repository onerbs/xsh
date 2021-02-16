// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import os

pub fn get_file_name(path string) string {
	items := path.split(os.path_separator)
	return '${items.last()}'
}

pub fn get_base_name(path string) string {
	is_dir := os.is_dir(path)
	items := path.split(os.path_separator)
	name := '${items.last()}'

	if is_dir {
		return '$name/'
	} else {
		parts := name.split('.')
		return parts[0..parts.len - 1].join('.')
	}
}
