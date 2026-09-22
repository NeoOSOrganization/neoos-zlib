#!/bin/bash
set -e
export PATH="$HOME/opt/cross-x86_64-neoos/bin:$PATH"
PREFIX="${PREFIX:-$(pwd)/build-output}"
mkdir -p "$PREFIX"
cd upstream
CC=x86_64-neoos-linux-musl-gcc AR=x86_64-neoos-linux-musl-ar CFLAGS="-fPIC" \
    ./configure --static --prefix="$PREFIX"
make clean 2>/dev/null || true
make -j"$(nproc)"
make install
