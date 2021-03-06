#!/usr/bin/env bash

# bib.sh:
#   A script for updating latex project '*.bib' library file.
#
#   This script, when bound to a global alias
#   makes it easy to copy-update the '*.bib'
#   library location from any child directory
#   of the project.
#
#
# author: Everett
# created: 2020-11-05 05:31
# Github: https://github.com/antiqueeverett/

# todo: find resource dir from any project child dir
# date: 2020-11-13 05:49

# source path of library.bib (auto-generated by mendeley)
targetDir='resources'
bibFile="$HOME/Dropbox/academic/mendeley/library.bib"


# copyUpdate
#   Finds resource directory current
#   working latex project and copies
#   over the '*.bib' file.
copyUpdate() {
    topmost=10
    FOUND=

    #   traverse parent directories upward to find resource directory
    for ((maxwalk = topmost; maxwalk > 0; --maxwalk)); do
        if [ -d "$targetDir" ]; then
            FOUND='yes'
            echo "Found latex project $targetDir directory"
            echo "Copy-updating $bibFile => ./resources"
            cd ./resources || return
            cp "$bibFile" ./
            return
        else
            cd "../"
        fi
    done
    if [ "$FOUND" = '' ]; then echo 'Resource directory not found' ;fi
}

copyUpdate
