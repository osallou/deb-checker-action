#!/bin/bash -l

set -e

echo "install build deps"
mk-build-deps --install --tool='apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes' debian/control

echo "apply patches"
quilt push -a 
echo "test binary build"
fakeroot debian/rules clean
fakeroot debian/rules binary



if [ "a$1" == "atrue"]; then
  lintian -I --pedantic --fail-on-warnings ../*.deb
else
  lintian -I --pedantic  ../*.deb
fi

$version=`dpkg-parsechangelog --show-field Version`
echo ::set-output name=debversion::$version

