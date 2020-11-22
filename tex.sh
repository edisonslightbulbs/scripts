#!/usr/bin/env bash

# tex.sh:
#   A script for compiling latex documents.
#
#   This script, when bound to a global alias
#   makes it easy to compile a latex project
#   from any child directory of the project.
#
# Author  : Everett
# Created : 2020-10-19 06:59
# Github  : https://github.com/antiqueeverett/


# clean
#   Cleans residual log files.
clean() {
    # use " ./ " so names with dashes won't become options
    rm -rf ./*.aux ./*.log ./*.bbl ./*.out ./*.toc ./*.gz ./*.lof ./*.lot ./*.cut ./*.blg
}


# compile
#   Compiles latex project.
#
# ARGUMENTS:
#   $1 name of main '*.tex' file
compile() {

    if [ -f "$pdf" ]; then rm -f "$pdf"; fi

    pdf=${1/tex/pdf} # output '*.pdf' file
    aux=${1/tex/aux} # output '*.aux' file

    pdflatex -draftmode -halt-on-error -file-line-error -interaction=batchmode "$1"

    if [ -f "$aux" ]; then bibtex "$aux"; fi

    pdflatex -draftmode -halt-on-error -file-line-error -interaction=batchmode "$1"
    pdflatex -interaction=batchmode "$1"
    clean
}


# show
#   Opens '*.pdf' file.
show() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        gio open main.pdf
    else [[ "$OSTYPE" == "darwin" ]];
        open main.pdf
    fi
}


# findFile:
#   Finds main latex file.
#
# ARGUMENTS:
#   $1 name of main latex file
findFile() {
    topmost=10
    FOUND=

    #   traverse parent directories upward to find main.tex
    for ((maxwalk = topmost; maxwalk > 0; --maxwalk)); do
        for file in *.tex; do

            if [ "$file" = "$main" ]; then

                # grep -w
                #   select only those lines containing
                #   matches that form whole words
                #
                # grep -q (tip: remove for trouble shooting)
                #   do not write anything to standard output & exit
                #   immediately with zero status match is found
                #
                if grep -w -q 'documentclass' "$PWD/$file"; then
                    FOUND='yes'
                    echo "Found $main"

                    # compile latex project
                    compile "$file"

                    # open '*.pdf' file iff it exists
                    if [ -f "$pdf" ]; then show; fi

                    return # break loop if we find what we are looking for
            fi
            fi
        done
        cd "../"
    done
    if [ "$FOUND" ]; then echo "$main not found" ;fi
}


# setMainFile
#   Sets main '*.tex' project file to be searched for.
setMainFile() {
    echo "Searching for $main";
    main="$1"
    findFile "$main"
}

# isTextFile
#   Checks for a '*.tex' file argument.
# @retval
#   return true if latex file argument found.
isTexFile() {
    fileExtension='.tex'
    if echo "$1" | grep -q "$fileExtension"; then
        true
    else
        false
    fi
}

# checkargs
#   Safeguards arguments (naively) and
#     prints help execution directives.
checkargs() {
    if (( $# > 2 )); then
        echo "Invalid argument"
        echo "example:"
        echo "       >_ tex.sh main.tex"
        echo "       >_ tex.sh main.tex -j10"
    else
        if isTexFile "$1"; then
            setMainFile "$1"
        elif isTexFile "$2"; then
            setMainFile "$2";
        fi
    fi
}

# default behaviour sets 'main.tex'
#   as latex main project file
main="main.tex"
if [ $# -eq 0 ]; then
    echo "Searching for $main" # Iff no args are specified
    findFile "$main"           #   find 'main.tex'
else
    checkargs "$@"
fi
