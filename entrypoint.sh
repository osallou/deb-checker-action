#!/bin/bash -l


quilt push -a
fakeroot debian/rules clean
fakeroot debian/rules binary

lintout=`lintian -I --pedantic ../*.deb`
lintexit=$?

ERRONLINT=0
if [ "a$1" == "atrue"]; then
	ERRONLINT=1
fi

if [ ${linkexit} -eq 0 ]; then
    echo ::set-output name=lint::success
else
    echo ::set-output name=lint::error
fi

if [ ${ERRONLINT} -eq 1 ]; then
   echo "test lintian exit code"
   exit lintexit

fi
