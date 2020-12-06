#!/usr/bin/env bash

# xmonad-sync
#   A script for sync-updating xmonad config files.
#
# Iff files do not exist create them,
# else update to most recent file version:

# author: Everett
# created: 2020-12-06 11:28
# Github: https://github.com/antiqueeverett/

local_layout="$HOME/.xmonad/util/layout.sh"
local_xmonad="$HOME/.xmonad/xmonad.hs"
local_xmobar="$HOME/.xmobarrc"

svn_layout="$HOME/dotfiles/xmonad/layout.sh"
svn_xmonad="$HOME/dotfiles/xmonad/xmonad.hs"
svn_xmobar="$HOME/dotfiles/xmonad/.xmobarrc"

# update xmonad
if [ -f "$local_xmonad" ]; then
    if [ "$local_xmonad" -ot "$svn_xmonad" ]; then
        cp -f "$svn_xmonad" "$local_xmonad"
        echo "xmonad.h: local <------- svn "
    else
        cp -f "$local_xmonad" "$svn_xmonad"
        echo "xmonad.h: local -------> svn"
    fi
else
    mkdir -p "$HOME/.xmonad/"
    cp "$svn_xmonad" "$local_xmonad"
    echo "xmonad.h: local <------- svn "
fi

# # update layout.sh
if [ -f "$local_layout" ]; then
    if [ "$local_layout" -ot "$svn_layout" ]; then
        cp -f "$svn_layout" "$local_layout"
        echo "layout.sh: local <------- svn "
    else
        cp -f "$local_layout" "$svn_layout"
        echo "layout.sh: local -------> svn "
    fi
else
    mkdir -p "$HOME/.xmonad/util/"
    cp "$svn_layout" "$local_layout"
    echo "layout.sh: local <------- svn "
fi

# update xmobar
if [ -f "$local_xmobar" ]; then
    if [ "$local_xmobar" -ot "$svn_xmobar" ]; then
        cp -f "$svn_xmobar" "$local_xmobar"
        echo "xmobarrc: local <------- svn "
    else
        cp -f "$local_xmobar" "$svn_xmobar"
        echo "xmobarrc: local -------> svn "
    fi
else
    cp "$svn_xmobar" "$local_xmobar"
    echo "xmobarrc: local <------- svn "
fi
