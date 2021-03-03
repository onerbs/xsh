// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import xsh

pub fn get_shelve() ?[]Book {
	state := xsh.get_state() ?
	return state.get_path().map(book)
}

pub fn (shelve []Book) find_sheets(name string) []Sheet {
	return shelve.get_sheets().filter(it.name == name)
}

fn (shelve []Book) get_sheets() []Sheet {
	mut sheets := []Sheet{}
	for book in shelve {
		sheets << book.sheets
		sheets << book.shelve.get_sheets()
	}
	return sheets
}
