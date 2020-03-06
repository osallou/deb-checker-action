# deb-checker-action

## About

github action to test debian package build against a debian:sid

* apply patches if any
* install build-deps from control file
* build binary
* run lintian
* outputs debian version from changelog

Simply expects to have a debian directory in root repo path, action will
try to build the package, after install of d/control build-deps.


## Roadmap

* execute autopkg-test
* test install/clean uninstall of generated package
