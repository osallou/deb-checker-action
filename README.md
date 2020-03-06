# deb-checker-action

## About

github action to test debian package build against a debian:sid

* apply patchesa if any
* install build-deps from control file
* build binary
* run lintian
* outputs debian version from changelog


## Roadmap

* execute autopkg-test
* test install/clean uninstall of generated package
