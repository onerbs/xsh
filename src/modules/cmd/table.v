// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module cmd

pub fn table(src string, rd string, cd string) string {
	mut rows := src.split(rd).map(it.split(cd).map(it.trim_space()))
	return mk_table(mut rows).map(it.join('  ')).join('\n')
}

fn mk_table(mut rows [][]string) [][]string {
	mut size := 0
	for row in rows {
		if row.len > size {
			size = row.len
		}
	}
	for mut row in rows {
		normalize(mut row, size)
	}
	mut metro := []int{len: size}
	for row in rows {
		for ix in 0 .. row.len {
			if row[ix].len > metro[ix] {
				metro[ix] = row[ix].len
			}
		}
	}
	for mut row in rows {
		set_metro(mut row, metro)
	}
	return *rows
}

fn normalize(mut row []string, size int) {
	if size == row.len {
		return
	}
	delta := size - row.len
	row << []string{len: delta}
}

fn set_metro(mut row []string, metro []int) {
	for ix in 0 .. row.len {
		row[ix] = fixed(row[ix], metro[ix])
	}
}
