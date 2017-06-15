#!/bin/bash

platform=$(uname -s)
arch=$(uname -m)

cd ${SRC_DIR}/make

makefile="Makefile-Linux-x86-64-gcc"
build_dir="Linux-x86-64-gcc"

# kakadu uses different Makefiles and build destinations
# for each platform/arch combo, right now we only deal with mac/linux/64/32
if [ $plaform == "Linux" ]; then
  if [ $arch != "x86_64" ]; then
    makefile="Makefile-Linux-x86-32-gcc"
    build_dir="Linux-x86-32-gcc"
  fi
elif [[ $platform == "Darwin" ]]; then
    makefile="Makefile-MAC-x86-all-gcc"
    build_dir="Mac-x86-64-gcc"
    if [ $arch != "x86_64" ]; then
	buildfile="Mac-x86-32-gcc"
    fi
fi

# need shared on apps for gdal
export CXXFLAGS="$CXXFLAGS -fPIC"

make -f $makefile
# do install
# we put libs and bins in top dirs
# we also make full copy for gdal build in $install_dir
cd $SRC_DIR

install_dir=$PREFIX/share/kakadu
mkdir -p $install_dir/bin $install_dir/lib

cp -a ./bin/$build_dir/* $PREFIX/bin
cp -a ./bin/$build_dir/* $install_dir/bin
cp -a ./lib/$build_dir/* $PREFIX/lib
cp -a ./lib/$build_dir/* $install_dir/lib

# these are for gdal jp2kak & jpipkak
find apps -name *.o -exec cp --parents {} $install_dir \;
find apps -name *.h -exec cp --parents {} $install_dir \;
find coresys -name *.o -exec cp --parents {} $install_dir \;
find coresys -name *.h -exec cp --parents {} $install_dir \;

# this is for jpipkak in gdal which builds this
cp apps/caching_sources/kdu_cache.cpp $install_dir/apps/caching_sources
