##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   .zshrc
# Update: 20100823 01:52:05
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
##################################

###################
#                 #
#    VARIABLES    #
#                 #
###################

export SHELL=$(which zsh)
export INPUTRC=${GYR_PATH}/dotfiles/inputrc
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zshistory
export BROWSER=firefox
export VIEWER=gpicview
# BUG fix for OpenOffice
export OOO_FORCE_DESKTOP=gnome
export ZLS_COLORS=${LS_COLORS}
## Anti-aliasing in the two toolkits (from resolve)
## Use this type of assignment to set the variable if not already set
(( ${+QT_XFT} )) || export QT_XFT=1
(( ${+GDK_USE_XFT} )) || export GDK_USE_XFT=1

# Set man path
manpath=(/usr/man /usr/share/man /usr/local/share/man /usr/local/man)
# Add .gyr.d to the target directorries
#cdpath=($cdpath . ${HOME}/.gyr.d)
#typeset -U cdpath

# exemplo:
#######
#
# test if a parameter is numeric
#  $ if [[ $1 == <-> ]] ; then
#         echo numeric
#    else
#         echo non-numeric
#    fi

# For Glob Qualifiers, i.e. print -l /**/*(*.m-1)
# man zshexpn

# Other interesting man pages:
# man zshall
# man zshbuiltins
# man zshmisc

###################
#                 #
#  COMMON SHELL   #
#                 #
###################
[ -z "${GYR_PATH}" ] && export GYR_PATH=${HOME}/.gyr.d
[ -f ${GYR_PATH}/dotfiles/gyrrc ] && . ${GYR_PATH}/dotfiles/gyrrc

# Load any supplementary scripts
if [ -d ${GYR_PATH}/dotfiles/bashrc.d ] ; then
    for config in "${GYR_PATH}"/dotfiles/zshrc.d/*.zsh ; do
        source "$config"
    done
fi
unset -v config

# vim: set filetype=sh fileformat=unix foldmethod=indent
