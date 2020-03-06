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



if [ "a$1" == "atrue"]; then
  lintian -I --pedantic --fail-on-warnings ../*.deb
else
  lintian -I --pedantic  ../*.deb
fi

version=`dpkg-parsechangelog --show-field Version`
echo "deb version: $version"
echo ::set-output name=debversion::$version

