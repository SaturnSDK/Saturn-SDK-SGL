#!/bin/bash
set -e

export TAG_NAME=`git describe --tags | sed -e 's/_[0-9].*//'`
export VERSION_NUM=`git describe --match "${TAG_NAME}_[0-9]*" HEAD | sed -e 's/-g.*//' -e "s/${TAG_NAME}_//"`
export MAJOR_BUILD_NUM=`echo $VERSION_NUM | sed 's/-[^.]*$//' | sed -r 's/.[^.]*$//' | sed -r 's/.[^.]*$//'`
export MINOR_BUILD_NUM=`echo $VERSION_NUM | sed 's/-[^.]*$//' | sed -r 's/.[^.]*$//' | sed -r 's/.[.]*//'`
export REVISION_BUILD_NUM=`echo $VERSION_NUM | sed 's/-[^.]*$//' | sed -r 's/.*(.[0-9].)//'`
export BUILD_NUM=`echo $VERSION_NUM | sed -e 's/[0-9].[0-9].[0-9]//' -e 's/-//'`

if [ $TAG_NAME -z ]; then
	TAG_NAME=unknown
fi

if [ $MAJOR_BUILD_NUM -z ]; then
	MAJOR_BUILD_NUM=0
fi

if [ $MINOR_BUILD_NUM -z ]; then
	MINOR_BUILD_NUM=0
fi

if [ $REVISION_BUILD_NUM -z ]; then
	REVISION_BUILD_NUM=0
fi

if [ $BUILD_NUM -z ]; then
	BUILD_NUM=0
fi

# Create the SGL library installer
mkdir -p $ROOTDIR/installerpackage/{org.opengamedevelopers.sega.saturn.sdk.lib.sgl/{data,meta},config}

cat > $ROOTDIR/installerpackage/org.opengamedevelopers.sega.saturn.sdk.lib.sgl/meta/package.xml << __EOF__
<?xml version="1.0" encoding="UTF-8"?>
<Package>
	<DisplayName>SEGA Saturn SDK GCC 3.4.6</DisplayName>
	<Description>GCC 3.4.6 optimised for the SEGA Saturn</Description>
	<Version>$MAJOR_BUILD_NUM.$MINOR_BUILD_NUM.$REVISION_BUILD_NUM.$BUILD_NUM</Version>
	<Name>org.opengamedevelopers.sega.saturn.sdk.lib.sgl</Name>
	<ReleaseDate>2014-06-15</ReleaseDate>
	<!--`git log --pretty=format:"%ci" -1 | sed -e 's/ [^ ]*$//g'`-->
</Package>
__EOF__

printf "Packaging $INSTALLDIR ... "
$QTIFWDIR/bin/archivegen $ROOTDIR/installerpackage/org.opengamedevelopers.sega.saturn.sdk.lib.sgl/data/directory.7z $INSTALLDIR/lib $INSTALLDIR/include
if [ $? -ne "0" ]; then
	printf "FAILED\n"
	exit 1
fi

printf "OK\n"

rm -rf $ROOTDIR/installerpackage/sgllib

$QTIFWDIR/bin/repogen -p $ROOTDIR/installerpackage -i org.opengamedevelopers.sega.saturn.sdk.lib.sgl $ROOTDIR/installerpackage/sgllib

