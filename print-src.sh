#!/usr/bin/env bash

# file name: print-src
#  Helper for printing source code
#
# author: Everett
# created: 2021-04-09 20:27
# Github: https://github.com/antiqueeverett/

find . -name "*.cpp" | xargs enscript --color=1 -C -Ecpp -fCourier7 -o - | ps2pdf - src.pdf
