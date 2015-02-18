########################################################
#
# Author: Gustavo Yokoyama Ribeiro <gyr AT protonmail DOT ch>
# File:   .profile
# Update: 20100114 02:17:09
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
########################################################

[ -f ~/.gyr.d/dotfiles/gyrprofile ] && . ~/.gyr.d/dotfiles/gyrprofile

if [ "$(hostname)" = 'ocdc' ]; then
    bash
fi
