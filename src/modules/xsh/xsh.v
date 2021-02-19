// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module xsh

import os
import term

pub fn get_exe_file() string {
	return os.args.first()
}

pub fn get_exe_name() string {
	return os.base(get_exe_file())
}

pub fn get_args() []string {
	return os.args[1..]
}

pub fn need_args(count int) ?[]string {
	args := get_args()
	if args.len < count {
		return error('not enough arguments: expected $count, got $args.len')
	}
	return args
}

pub fn need_env(name string) ?string {
	value := os.getenv(name)
	if value.len == 0 {
		return error('the environment variable "$name" is unset')
	}
	return value
}

pub fn clean_lines(file string) []string {
	lines := os.read_lines(file) or { return []string{} }
	return clean(lines)
}

// clean remove blank lines and comments
fn clean(lines []string) []string {
	mut arr := []string{cap: lines.len}
	for line in lines.map(it.trim_space()) {
		if line.len > 0 && !line.starts_with('# ') {
			arr << line
		}
	}
	return arr
}

pub fn fail(err string) int {
	error_tag := term.red('Error')
	eprintln('$error_tag: $err')
	return 1
}
