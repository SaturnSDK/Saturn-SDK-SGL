#!/bin/bash
set -e

if [ ! -d $DOWNLOADDIR ]; then
	mkdir -p $DOWNLOADDIR
fi

cd $DOWNLOADDIR

wget -c http://koti.kapsi.fi/~antime/sega/files/sgl-fixed.tar.bz2

