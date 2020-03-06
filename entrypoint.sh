#!/bin/bash -l

set -e

echo "build source package"
dpkg-source -b .

echo "install build deps"
mk-build-deps --install --tool='apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes' debian/control

echo "test binary build"
quilt push -a
fakeroot debian/rules clean
fakeroot debian/rules binary



if [ "a$1" == "atrue"]; then
  lintian -I --pedantic --fail-on-warnings ../*.deb
else
  lintian -I --pedantic  ../*.deb
fi

$version=`dpkg-parsechangelog --show-field Version`
echo ::set-output name=debversion::$version

