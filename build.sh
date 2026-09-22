#!/bin/bash
set -e
# The hosted NeoOS cross toolchain (neoos-hosted-gcc). Overridable so a
# fresh checkout -- e.g. neoos-os-builder's scratch directory -- can
# point at wherever it lives.
NEOOS_TOOLCHAIN="${NEOOS_TOOLCHAIN:-$HOME/opt/cross-x86_64-neoos}"
export PATH="$NEOOS_TOOLCHAIN/bin:$PATH"
PREFIX="${PREFIX:-$(pwd)/build-output}"
mkdir -p "$PREFIX"
cd upstream
CC=x86_64-neoos-linux-musl-gcc AR=x86_64-neoos-linux-musl-ar CFLAGS="-fPIC" \
    ./configure --static --prefix="$PREFIX"
make clean 2>/dev/null || true
make -j"$(nproc)"
make install
