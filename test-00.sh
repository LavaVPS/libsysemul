#!/bin/sh

set -e
set -x

test -f src/libsysemul.so

LD_PRELOAD=src/libsysemul.so
LD_PRELOAD=$LD_PRELOAD true
if command -v prlimit > /dev/null 2>&1
then
	LD_PRELOAD=$LD_PRELOAD prlimit
else
	LD_PRELOAD=$LD_PRELOAD src/test-prlimit64
fi
