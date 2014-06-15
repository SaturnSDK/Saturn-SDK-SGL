#!/bin/bash
set -e

mkdir -p $INSTALLDIR/include/sgl

cp -v $SRCDIR/sgl/inc/*.h $INSTALLDIR/include/sgl/
