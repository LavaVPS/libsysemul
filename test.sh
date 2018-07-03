#!/bin/sh

set -e
set -x

test -f src/x86/libsysemul.so
test -f src/x64/libsysemul.so

LD_PRELOAD=src/x64/libsysemul.so
arch=`uname -m`
case $arch in
	x86_64)
		LD_PRELOAD=src/x64/libsysemul.so
		;;
	i686)
		LD_PRELOAD=src/x86/libsysemul.so
		;;
	*)
		echo "unsupported architecture"
		false
		;;
esac

LD_PRELOAD=$LD_PRELOAD true
LD_PRELOAD=$LD_PRELOAD prlimit
