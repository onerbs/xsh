// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import cmd

fn test_fixed() {
	assert cmd.fixed('some', 4) == 'some'
	assert cmd.fixed('some', 6) == 'some  '
}
