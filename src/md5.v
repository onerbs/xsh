// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import os
import xsh
import cmd
import strings
import crypto.md5

// Usage: md5 [<options>] <input>

// Options:
//   -f    Enable the file mode
//   -     Read <input> from the standard input

// Examples:
//   md5 hello
//   md5 -f md5.v other.v
//   echo hello | md5 -
//   find -type f | md5 -f -

fn main() {
	mut args := xsh.need_args(1) or { exit(fatal(err)) }

	file_mode := cmd.parse_flag(mut args, ['-f'])
	from_stdin := args == ['-']

	mut items := []string{}
	if from_stdin && file_mode {
		lines := os.get_lines()
		if lines.len == 1 {
			items << lines[0].split(' ')
		} else {
			items << lines
		}
	} else if from_stdin {
		items = os.get_lines()
	} else if file_mode {
		items << args
	} else {
		items = [args.join(' ')]
	}

	if file_mode {
		println(cmd.table(hash_files(items), '\n', ':'))
	} else {
		println(items.map(md5.hexhash(it)).join('\n'))
	}
}

fn hash_files(items []string) string {
	mut b := strings.new_builder(items.len * 32)
	for item in items {
		if os.is_dir(item) {
			exit(fatal('"$item" is a directory'))
		}
		bs := os.read_bytes(item) or { exit(fatal(err)) }
		hash := md5.sum(bs).hex()
		b.writeln('$item:$hash')
	}
	b.go_back(1)
	return '$b'
}

fn fatal(err string) int {
	return xsh.fail('md5: $err')
}
