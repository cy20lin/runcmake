#!/bin/sh
## gaw-runcmake.sh --- A =gawk= implementation of =runcmake=
##
## Copyright (c) 2017 ChienYu Lin
##
## Author: ChienYu Lin <cy20lin@gmail.com>
## License: MIT
##

# using gawk to launch cmake script 
# \x27 => ' (single quotation mark)
awk 'BEGIN {
    argc=ARGC-2;
    argv=ARGV[2];
    cmake="/bin/env cmake";
    def="\x27-DRUNCMAKE=1\x27";
    def=def" \x27-DRUNCMAKE_CURRENT_SCRIPT=" ARGV[1] "\x27";
    def=def" \x27-DARGC=" argc "\x27";
    if(argc > 0) {
        def=def" \x27-DARGV0=" ARGV[2] "\x27";
        argc=0;
        for (i=3; i<ARGC; ++i) {
            ++argc;
            def=def " \x27-DARGV" argc "=" ARGV[i] "\x27";
            argv=argv ";" ARGV[i];
        }
    }
    argn=argv;
    def=def " \x27-DARGV=" argv "\x27";
    def=def " \x27-DARGN=" argn "\x27";
    cmd=cmake " " def " -P \x27" ARGV[1] "\x27";
    system(cmd);
}' "${@}"
