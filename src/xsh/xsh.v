// Copyright (c) 2024 Alejandro Elí
// All rights reserved. This file is subject to the terms and conditions
// defined in the LICENSE file, which is part of this source code package

module xsh

import uwu

const home = uwu.need_env('XSH_HOME') or { uwu.catch(err) }
