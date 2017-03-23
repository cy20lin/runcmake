#!/bin/sh
## test.sh --- Testing script for =runcmake=
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

source "${testdir}/test_args.sh"
exit $result
