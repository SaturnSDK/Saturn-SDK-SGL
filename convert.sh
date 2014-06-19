#!/bin/bash
set -e

[ -d $BUILDDIR/sgllib ] && rm -rf $BUILDDIR/sgllib

mkdir -p $BUILDDIR/sgllib

cd $BUILDDIR/sgllib

mkdir lib
cp $SRCDIR/sgl/lib/* ./lib
chmod 644 ./lib/*

for file in ./lib/*.a; do
	$SATURNSDK/toolchain/bin/${PROGRAM_PREFIX}objcopy -Icoff-sh -Oelf32-sh $file
done

for file in ./lib/*.o; do
	$SATURNSDK/toolchain/bin/${PROGRAM_PREFIX}objcopy -Icoff-sh -Oelf32-sh $file
done

mkdir -p $INSTALLDIR/lib/sgl

cp -v ./lib/* $INSTALLDIR/lib/sgl/
