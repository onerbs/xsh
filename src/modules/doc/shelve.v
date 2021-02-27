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
	return shelve.get_sheet_list().filter(simple_path(it) == name).map(sheet)
}

fn (shelve []Book) get_sheet_list() []string {
	return flat<string>(shelve.map(it.sheets))
}

// Someday, this will be easier...
fn flat<T>(xs [][]T) []T {
	mut unit := []T{cap: count<T>(xs)}
	for arr in xs {
		for e in arr {
			unit << e
		}
	}
	return unit
}

fn count<T>(xs [][]T) int {
	return xs.map(it.len).reduce(sum, 0)
}

fn sum(a int, b int) int {
	return a + b
}
