// Copyright (c) 2021 Alejandro Elí. All rights reserved.
// This file is subject to the terms and conditions defined in
// the LICENSE file, which is part of this source code package.

module cmd

import os

// abs_path return the absolute path to the provided file,
// even if the specified file does not exists.
// Unix-style paths only.
pub fn abs_path(path string) string {
	return if path in ['..', '../'] {
		parent()
	} else if path in ['', '.', './'] {
		os.getwd()
	} else if path.starts_with('../') {
		abs_path(join_path(parent(), path[3..]))
	} else if path.starts_with('./') {
		abs_path(join_path(os.getwd(), path[2..]))
	} else if '/../' in path {
		xs := path.split_nth('/../', 2)
		abs_path(join_path(os.dir(xs[0]), xs[1]))
	} else if path.starts_with('/') {
		path
	} else {
		join_path(os.getwd(), path)
	}
}

// real_path return the absolute real path to the provided file.
pub fn real_path(path string) string {
	return abs_path(os.real_path(path))
}

// parent return the path to the parent directory.
fn parent() string {
	return os.dir(os.getwd())
}
