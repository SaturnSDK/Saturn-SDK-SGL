#!/bin/bash

[ -d $INSTALLDIR ] && rm -rf $INSTALLDIR

./download.sh

if [ $? -ne 0 ]; then
	echo "Failed to retrieve the files necessary for building the SGL package"
	exit 1
fi

./extract.sh

if [ $? -ne 0 ]; then
	echo "Failed to extract the files necessary for building the SGL package"
	exit 1
fi

./convert.sh

if [ $? -ne 0 ]; then
	echo "Failed to convert the SGL libraries to the ELF format"
	exit 1
fi

./copyheaders.sh

if [ $? -ne 0 ]; then
	echo "Failed to copy the SGL headers"
	exit 1
fi

