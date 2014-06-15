#!/bin/bash
set -e

if [ ! -d $SRCDIR ]; then
	mkdir -p $SRCDIR
fi

cd $SRCDIR

if [ ! -d sgl ]; then
	tar xvjpf $DOWNLOADDIR/sgl-fixed.tar.bz2
fi

