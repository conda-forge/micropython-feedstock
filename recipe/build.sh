#!/bin/bash
set -exo pipefail

export CFLAGS_EXTRA="$CFLAGS"

if [ "$(uname)" == "Linux" ]; then
    sed -i.bak 's/gcc/$(GCC)/g' $SRC_DIR/py/mkenv.mk
fi
sed -i.bak 's/-Werror//g' $SRC_DIR/ports/unix/Makefile

make -C ${SRC_DIR}/mpy-cross -j${CPU_COUNT} V=1 BUILD="${SRC_DIR}/mpy-cross/build"
make -C ${SRC_DIR}/ports/unix install -j${CPU_COUNT} V=1 BUILD="${SRC_DIR}/ports/unix/build-standard" PREFIX=${PREFIX}
mkdir -p ${PREFIX}/bin/
install -m 755 ${SRC_DIR}/mpy-cross/build/mpy-cross ${PREFIX}/bin/
