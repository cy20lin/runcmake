#!/bin/sh
## install.sh --- Install =runcmake=
##
## Copyright (c) 2017 ChienYu Lin
##
## Author: ChienYu Lin <cy20lin@gmail.com>
## License: MIT
##

projdir="$(dirname $(readlink -f $0))"
testdir="${projdir}/test"
srcdir="${projdir}/src"
bindir="${projdir}/bin"
runcmake="${srcdir}/$(${srcdir}/select.sh)"

test -z "$1" && echo "Install failed." && exit 1
test ! -d "$1/bin" && mkdir -p -- "$1/bin"
cp -f -- "${runcmake}" "$1/bin/runcmake"
