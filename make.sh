#!/bin/bash -x

autoreconf -fis
mkdir build
pushd build
../configure --prefix=/usr --libdir=/usr/lib/powerpc64le-linux-gnu --enable-maintainer-mode --program-prefix=eu-
make -j 10
popd

gcc -static -O0 -g -htm set_tm_sprs_and_generate_coredump.c -o set_tm_sprs_and_generate_coredump
ulimit -c unlimited
if [ "`cat /proc/sys/kernel/core_pattern`" == "core" ]; then
./set_tm_sprs_and_generate_coredump
LD_LIBRARY_PATH=./build/backends ./build/src/readelf --notes ./core |& egrep "tfhar|tfiar|texasr"
exit 0
else
echo "please, adjust core_pattern to 'core'"
exit 1
fi

