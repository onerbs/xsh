// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module doc

import os

const (
	base  = 'file'
	items = [
		base,
		'${base}.one',
		'${base}.one.two',
		'${base}.one.two.three',
	]
)

fn test_simple_path() {
	prefix := os.getwd()
	for item in doc.items {
		assert simple_path(os.join_path(prefix, item)) == doc.base
	}
}

fn test_simple() {
	for item in doc.items {
		assert simple(item) == doc.base
	}
}
