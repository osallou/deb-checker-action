#!/bin/bash -l

set -e

echo "install build deps"
mk-build-deps --install --tool='apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes' debian/control

echo "apply patches"
export QUILT_PATCHES=debian/patches
export QUILT_REFRESH_ARGS="-p ab --no-timestamps --no-index"
if [ -e debian/patches/series ]; then
  quilt push -a
fi
echo "test binary build"
fakeroot debian/rules clean
fakeroot debian/rules binary


echo "run lintian"
lintian -I --pedantic  ../*.deb

version=`dpkg-parsechangelog --show-field Version`
echo "deb version: $version"
echo ::set-output name=debversion::$version

