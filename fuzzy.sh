#!/usr/bin/env bash

# file name: fuzzy
#     Intuitive fuzzy finding with git projects with submodules
#
# author: Everett
# created: 2021-03-12 07:52
# Github: https://github.com/antiqueeverett/

function find_git_root() {
    gitproject="$(git rev-parse --show-toplevel 2>/dev/null)"
    cd "$gitproject" || return

    # if file does not exist, assume git root
    # else if file file exists, assume git submodule
    if [ ! -f .git ]; then
        echo "$gitproject"
    else
        cd ../
        find_git_root
    fi
}

find_git_root
