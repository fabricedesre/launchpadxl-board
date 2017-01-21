// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this file,
// You can obtain one at http://mozilla.org/MPL/2.0/.

// We won't use the standard library because it requires OS abstractions like threads and files and
// those are not available in this platform.
#![no_std]

#![feature(core_intrinsics)]

#[macro_use]
extern crate cc3200;

#[macro_use]
extern crate log;

pub mod bma222;
pub mod tmp006;
