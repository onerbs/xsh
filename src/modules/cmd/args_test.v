// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import cmd

fn test_parse_flag() {
	mut args := ['some', '--dir', 'argument', '-f']
	is_d := cmd.parse_flag(mut args, ['-d', '--dir'])
	is_f := cmd.parse_flag(mut args, ['-f', '--file'])
	is_h := cmd.parse_flag(mut args, ['-h', '--help'])
	assert is_d == true
	assert is_f == true
	assert is_h == false
	assert args == ['some', 'argument']
}

fn test_parse_flag_value() {
	mut args := ['some', '--dir', 'ahoy', 'argument', '-f']
	d_value := cmd.parse_flag_value(mut args, ['-d', '--dir'], 'fall-back')
	f_value := cmd.parse_flag_value(mut args, ['-f', '--file'], 'fall-back')
	assert d_value == 'ahoy'
	assert f_value == 'fall-back'
	assert args == ['some', 'argument']
}
