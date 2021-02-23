// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module cmd

pub fn parse_flag(mut args []string, flags []string) bool {
	mut status := false
	for f in flags {
		if f in args {
			args.delete(args.index(f))
			status = true
		}
	}
	return status
}

pub fn parse_flag_value(mut args []string, flags []string, fb string) string {
	mut value := fb
	for f in flags {
		if f in args {
			index := args.index(f)
			indey := index + 1
			if indey < args.len {
				value = args[indey]
				args.delete(indey)
			}
			args.delete(index)
		}
	}
	return value
}
