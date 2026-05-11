#!/bin/bash
set -exo pipefail

sed -i.bak 's/gcc/$(GCC)/g' ${SRC_DIR}/py/mkenv.mk
sed -i.bak 's/-Werror//g' ${SRC_DIR}/ports/unix/Makefile

make -C ${SRC_DIR}/mpy-cross -j${CPU_COUNT} \
    CFLAGS_EXTRA="${CFLAGS}" CPP="$CC -E"

LDFLAGS_EXTRA=""
[ "$(uname)" != "Darwin" ] && LDFLAGS_EXTRA="-lrt"

make -C ${SRC_DIR}/ports/unix -j${CPU_COUNT} V=1 \
    CFLAGS_EXTRA="${CFLAGS}" LDFLAGS_EXTRA="${LDFLAGS_EXTRA}"

install -m 755 ${SRC_DIR}/ports/unix/build-standard/micropython ${PREFIX}/bin/
