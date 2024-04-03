#!/usr/bin/env bash
set -ex
if [[ -n "$mpi" && "$mpi" != "nompi" ]]; then
  export FF_OPTIONS="${FF_OPTIONS} --with-mpi=yes"
else
  export FF_OPTIONS="${FF_OPTIONS} --without-mpi"
fi

echo "**************** F R E E F E M  B U I L D  S T A R T S  H E R E ****************"

autoreconf -i
export FFLAGS=-fallow-argument-mismatch
## Required to make linker look in correct prefix
export LIBRARY_PATH="${PREFIX}/lib"
export LD_LIBRARY_PATH="${PREFIX}/lib"

#            --enable-optim \
#            --enable-ffcs \
#            --enable-m64 \
./configure --prefix=$PREFIX \
            --enable-summary \
            ${FF_OPTIONS}

make -j $CPU_COUNT
make install
cp $PREFIX/lib/ff++/${PKG_VERSION}/lib/msh3${SHLIB_EXT} $PREFIX/lib
#rm $PREFIX/lib/ff++/${PKG_VERSION}/lib/*.${SHLIB_EXT} || true # to avoid conda DSO errors
rm $PREFIX/lib/ff++/${PKG_VERSION}/lib/*.a || true # static libraries are not allowed
make check -j $CPU_COUNT check

echo "**************** F R E E F E M  B U I L D  E N D S  H E R E ****************"
