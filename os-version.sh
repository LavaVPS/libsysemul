#!/bin/sh

error()
{
	echo "$@" >&2
	exit 1
}

if [ ! -f '/etc/os-release' ]
then
	error 'Missing /etc/os-release'
fi


. /etc/os-release

if [ -z "${VERSION_ID}" ]
then
	if [ "${ID}" = 'debian' ]
	then
		# assume debian 10
		VERSION_ID='10'
	fi
fi

echo "${ID}${VERSION_ID}"
exit 0
