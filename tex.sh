#!/usr/bin/env bash

# ctex.sh:
#   A script for compiling latex documents.
#
# Author  : Everett
# Created : 2020-10-19 06:59
# Github  : https://github.com/antiqueeverett/


# house keeping
function clean() {
    rm -rf *.aux *.log *.bbl *.out *.toc *.gz *.lof *.lot *.cut *.blg
}


# compile():
# Compiles main latex file.
#
# ARGUMENTS:
#   $1 name of main latex file
#
function compile() {

    pdf=${1/tex/pdf}

    if [ -f "$pdf" ]; then
        rm -f "$pdf"
    fi

    pdflatex -interaction=batchmode "$1"

    aux=${1/tex/aux}

    if [ -f "$aux" ]; then
        bibtex "$aux"
    fi

    pdflatex -interaction=batchmode "$1"
    pdflatex -interaction=batchmode "$1"
    pdflatex -interaction=batchmode "$1"

    clean
}


# show():
# Show *.pdf
#
function show() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        gio open main.pdf
    else [[ "$OSTYPE" == "darwin" ]];
        open main.pdf
    fi
}


# findMain():
#   Finds a given main latex file.
#
# ARGUMENTS:
#   $1 name of main latex file
#
function build() {
    topmost=10

    #   traverse parent directories upward to find main.tex
    for ((maxwalk = topmost; maxwalk > 0; --maxwalk)); do
        for file in *.tex; do

            if [ "$file" = "main.tex" ]; then

                # grep -w
                #   select only those lines containing
                #   matches that form whole words
                #
                # grep -q (tip: remove for trouble shooting)
                #   do not write anything to standard output & exit
                #   immediately with zero status match is found
                #
                if grep -w -q 'documentclass' "$PWD/$file"; then
                    echo "Found main.tex!"
                    compile "$file"
                    show
                    return # break loop if we find what we are looking for
                fi
            else
                echo "main.tex not found!"
            fi
        done

        cd "../"
    done
}


# todo: introduce option to pass main latex file as an arg
#
#   If no main file is given, fall back to find main.tex.
#
# if [ $# -eq 0 ]; then
#     echo "No arguments given!"
#     echo "Falling back to search for main.tex"
#     build "main.tex"
# else
#     build "$1"
# fi

build
