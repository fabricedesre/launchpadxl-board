#!/bin/bash

set -e

curl https://sh.rustup.rs -sSf -o rustup.sh
chmod +x ./rustup.sh
./rustup.sh -y
export PATH=/home/travis/.cargo/bin:$PATH
rustup override set nightly-2017-01-18
rustup component add rust-src
cargo install --vers 0.3.4 xargo
cargo --version
xargo --version
rustc --version
arm-none-eabi-gcc --version

cp examples/config.rs.sample examples/config.rs

# Build just library.
xargo build --target=thumbv7em-none-eabi
xargo build --target=thumbv7em-none-eabi --release

for example_file in examples/*.rs; do
    example=$(basename ${example_file/.rs/})
    if [ "${example}" != "config" ]; then
        ./build.sh --example ${example}
        ./build.sh --example ${example} --release
    fi
done

cd numeric_utils && cargo test
