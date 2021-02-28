// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module main

import doc

fn test_simple_path() {
	assert doc.simple_path('/path/to/file') == 'file'
	assert doc.simple_path('/path/to/file.c') == 'file'
	assert doc.simple_path('/path/to/file.c.v') == 'file.c'
}

fn test_simple() {
	assert doc.simple('file') == 'file'
	assert doc.simple('file.c') == 'file'
	assert doc.simple('file.c.v') == 'file.c'
}
