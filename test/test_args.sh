#!/bin/sh
## test_args.sh --- Test arguments passed into CMake script
##
## Copyright (c) 2017 ChienYu Lin
##
## Author: ChienYu Lin <cy20lin@gmail.com>
## License: MIT
##

show_args() {
    argc=$#
    echo "ARGC=${argc}"
    if test "$#" -gt 0
    then
        argv="${1}"
        echo "ARGV0=${1}"
        for i in $(seq 2 $#);
        do
            prev_i=$(expr ${i} - 1)
            eval echo "ARGV${prev_i}=\"\${${i}}\""
            eval "argv=\"${argv};\${${i}}\""
        done
    fi
    echo "ARGV=${argv}"
    echo "ARGN=${argv}"
}

args_count=0
add_args() {
    args=("${@}")
    eval "args${args_count}=(\"\${args[@]}\")"
    args_count=$(expr ${args_count} + 1)
}

dos2unix(){
    sed 's@\r\n@\n@g'
}

test_args() {
    args_data_sh=$(show_args "${@}")
    args_data_cmake=$("${runcmake}" "${testdir}/show_args.cmake" "${@}" 2>&1 | dos2unix)
    # echo args_data_sh
    # echo "${args_data_sh}"
    # echo args_data_cmake
    # echo "${args_data_cmake}"
    if test "${args_data_sh}" == "${args_data_cmake}"
    then
        result=$?
    else
        result=$?
    fi
    return ${result}
}

show_args_count(){
    echo "count=${#}"
}

test_all_args() {
    success_count=0
    failure_count=0
    args_end=$(expr ${args_count} - 1)
    for i in $(seq 0 ${args_end});
    do
        eval "args=(\"\${args${i}}\")"
        test "${#args}" -eq 0 && args=()
        if test_args "${args[@]}"
        then
            echo "test[${i}]: passed"
            success_count=$(expr ${success_count} + 1)
        else
            echo "test[${i}]: failed"
            failure_count=$(expr ${failure_count} + 1)
        fi
    done
    echo
    if test "${success_count}" -eq "${args_count}" 
    then
        result=$?
        echo "All test passed."
        return 0
    else
        result=$?
        echo "Some test failed."
    fi
    return ${result}
}

add_args
# [TODO]: Fix problems when testing with empty arguments.
# add_args ""
# add_args "" ""
add_args 1
add_args 1 2
add_args 1 2 3
add_args 1 2 3 4
add_args 1 2 3 4 5
add_args 1 2 3 4 5 6
add_args 1 2 3 4 5 6 7
add_args 1 2 3 4 5 6 7 8
add_args 1 2 3 4 5 6 7 8 9
add_args 1 2 3 4 5 6 7 8 9 10
add_args 1 jaasdfas oipwue asudfu usudfu uudufu udfuau udfua d
add_args asd adslfj dslfj sdfj klalsdfkj sdlfkj
add_args asd ads123lfj 2 12kj123311uo
add_args "\x123" "" "" " df " "\x00ls"
test_all_args
result=$?
return ${result}
