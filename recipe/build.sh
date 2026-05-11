#!/bin/bash
set -ex

if [ "$(uname)" != "Darwin" ]; then
    sed -i.bak 's/gcc/$(GCC)/g' $SRC_DIR/py/mkenv.mk
fi

sed -i.bak 's/-Werror//g' $SRC_DIR/ports/unix/Makefile

export CFLAGS_EXTRA="$CFLAGS"
export CPP="$CC -E"

make -C $SRC_DIR/mpy-cross -j${CPU_COUNT} \
    BUILD="$SRC_DIR/mpy-cross/build"

if [ "$(uname)" != "Darwin" ]; then
    export LDFLAGS_EXTRA="-lrt"
fi
make -C $SRC_DIR/ports/unix -j${CPU_COUNT} V=1

install -m 755 ${SRC_DIR}/ports/unix/build-standard/micropython ${PREFIX}/bin/
