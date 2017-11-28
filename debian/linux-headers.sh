#!/bin/sh

set -e

unset LINUX_INCLUDE
for i in /usr/src/linux-headers-4.4.*; do
	if [ -f "$i/include/uapi/video/rk_vpu_service.h" ]; then
		LINUX_INCLUDE="$i/include"
	fi
done

if [ "$LINUX_INCLUDE" = "" ]; then
	echo "Could not find linux headers containing rk_vpu_service.h"
	exit 1
fi

rm -rf debian/linux-headers
mkdir -p debian/linux-headers/linux
cp -r "$LINUX_INCLUDE/uapi/drm" debian/linux-headers/
cp -r "$LINUX_INCLUDE/uapi/video" debian/linux-headers/
cp "$LINUX_INCLUDE/linux/compiler.h" debian/linux-headers/linux/
