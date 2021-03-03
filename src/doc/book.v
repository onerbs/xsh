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

pub fn book(root string) Book {
	mut shelve := []Book{}
	mut sheets := []Sheet{}
	for file in get_files(root) {
		if os.is_dir(file) {
			shelve << book(file)
		} else {
			sheets << sheet(file)
		}
	}
	return Book{
		origin: root
		name: os.base(root) + '/'
		books: books
		sheets: sheets
	}
}

fn get_files(root string) []string {
	files := os.ls(root) or { []string{cap: 0} }
	return files.filter(valid_file).map('$root/$it')
}

fn valid_file(name string) bool {
	return if name.starts_with('_') {
		false
	} else if name.ends_with('_.sh') {
		false
	} else if name == '.git' {
		false
	} else {
		true
	}
}
