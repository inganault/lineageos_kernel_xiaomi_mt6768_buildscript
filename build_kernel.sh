#!/bin/sh

cd "$(dirname "$0")/kernel"

# clang build

export ARCH="arm64"
export CLANG_TRIPLE="aarch64-linux-gnu-"
export CROSS_COMPILE="aarch64-linux-gnu-"
export CROSS_COMPILE_ARM32="arm-linux-gnueabi-"
MAKE_OPT="O=out LLVM=1"

#make $MAKE_OPT mrproper
rm -rf out/

set -e
make $MAKE_OPT lancelot_defconfig
make $MAKE_OPT -j$(nproc) Image.gz
