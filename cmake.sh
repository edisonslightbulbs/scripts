#!/usr/bin/env bash

# cmake.sh:
#     Executes cmake commands.
# author: Everett
# created: 2020-11-10 17:08
# Github: https://github.com/antiqueeverett/

# build:
#   Executes cmake build process.
build (){
    local PROJECT_DIR="$1"
    cd "$PROJECT_DIR" || return
    if [ -d "$PROJECT_DIR/build" ]; then rm -rf "$PROJECT_DIR/build"; fi

    mkdir "$PROJECT_DIR/build" && cd "$PROJECT_DIR/build" || return
    cmake "$PROJECT_DIR"
    make

    cd "$PROJECT_DIR/build/bin" || return
    #./main --logtostderr=1
}

# findfile:
#   Finds project CMakeLists.txt FILE
findCMakeFile (){
    for ((maxwalk = 5; maxwalk > 0; --maxwalk)); do
        if [ -e "CMakeLists.txt" ]; then
            if grep -w -q 'project' "CMakeLists.txt" && grep -w -q 'cmake_minimum_required' "CMakeLists.txt"; then
                echo " -- Project CMakeLists.txt file found"
                build "$PWD"
                return
            else
                echo " -- Project CMakeLists.txt file not found"
            fi
        fi
        cd "../"
    done
}

main () {
    local CURR_DIR="$PWD"
    findCMakeFile
    cd "$CURR_DIR" || return
}

main
