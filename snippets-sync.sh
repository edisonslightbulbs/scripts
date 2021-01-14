#!/usr/bin/env bash

# snippet-sync
#   A script for sync-updating Ultisnips snippets from a central
#   repository.
#
# author: Everett
# created: 2020-12-12 09:20
# Github: https://github.com/antiqueeverett/

targetdir="$HOME/.vim/UltiSnips/"
sourcedir="$HOME/dotfiles/vim/pluginconfig/snippets/"

mkdir -p $targetdir
cd $sourcedir || return
cp ./*.snippets $targetdir
