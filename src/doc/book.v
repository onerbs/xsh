// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import os

struct Book {
pub:
	origin string
	name   string
	shelve []Book
	sheets []Sheet
}

pub fn book(origin string) Book {
	mut shelve := []Book{}
	mut sheets := []Sheet{}
	for file in get_files(origin) {
		if os.is_dir(file) {
			shelve << book(file)
		} else {
			sheets << sheet(file)
		}
	}
	name := os.base(origin) + '/'
	return Book{origin, name, shelve, sheets}
}

fn get_files(root string) []string {
	files := os.ls(root) or { []string{len: 0} }
	return files.filter(valid_file).map('$root/$it')
}

fn valid_file(name string) bool {
	return !(name.starts_with('_') || name.ends_with('_.sh') || name == '.git')
}
