##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   .zprofile
# Update: 20080319 15:27:25
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
##################################


[ -f ${HOME}/.gyr.d/dotfiles/gyrprofile ] && . ${HOME}/.gyr.d/dotfiles/gyrprofile

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

export SHELL=/bin/zsh
