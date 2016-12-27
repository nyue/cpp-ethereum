#!/usr/bin/env sh

mkdir -p build
cd build

case $(uname -s) in
    Linux )
        NAME=cmake-3.7.1-Linux-x86_64
        SHA256=7b4b7a1d9f314f45722899c0521c261e4bfab4a6b532609e37fef391da6bade3
        ;;
    Darwin )
        NAME=cmake-3.7.1-Darwin-x86_64
        SHA256=1851d1448964893fdc5a8c05863326119f397a3790e0c84c40b83499c7960268
        ;;
esac

URL=https://cmake.org/files/v3.7/$NAME.tar.gz
BIN=$(pwd)/$NAME/bin

if ! $BIN/cmake --version; then
    echo "Downloading $NAME (expected checksum $SHA256)"
    curl -s "$URL" | tee >(tar -xz) | sha256sum | grep -q "$SHA256"
    if ! $?; then
        echo "Failed!"
        exit 1
    fi
fi

export PATH=$BIN:$PATH
cd ..
