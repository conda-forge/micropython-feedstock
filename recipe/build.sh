#!/bin/bash
set -ex

export CFLAGS_EXTRA="$CFLAGS"

if [ "$(uname)" == "Linux" ]; then
    sed -i.bak 's/gcc/$(GCC)/g' $SRC_DIR/py/mkenv.mk
fi
sed -i.bak 's/-Werror//g' $SRC_DIR/ports/unix/Makefile

make -C $SRC_DIR/mpy-cross -j${CPU_COUNT} BUILD="$SRC_DIR/mpy-cross/build"
make -C $SRC_DIR/ports/unix submodules -j${CPU_COUNT} V=1
make -C $SRC_DIR/ports/unix -j${CPU_COUNT} V=1
install -m 755 ${SRC_DIR}/ports/unix/build-standard/micropython ${PREFIX}/bin/
