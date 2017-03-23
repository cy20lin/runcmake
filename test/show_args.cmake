#!/bin/env runcmake
## show_args.cmake --- Show arguments
##
## Copyright (c) 2017 ChienYu Lin
##
## Author: ChienYu Lin <cy20lin@gmail.com>
## License: MIT
##

message("ARGC=${ARGC}")
if(ARGC GREATER 0)
  math(EXPR end "${ARGC} - 1")
  foreach(i RANGE 0 ${end})
    message("ARGV${i}=${ARGV${i}}")
  endforeach()
endif()
message("ARGV=${ARGV}")
message("ARGN=${ARGN}")
