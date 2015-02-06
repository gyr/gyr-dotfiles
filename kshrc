##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   .kshrc
# Update: 20090903 10:09:58
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
##################################

export SHELL=/bin/ksh
#export COLUMNS=1024
export COLUMNS=225

########
# sets input line and text editors
set -o vi

. ~/.gyr.d/dotfiles/gyrrc

HOST=`hostname`
HOST=${HOST%%.*}
PS1=']0;${HOST}${PR_CC_VIEW_NAME}${HOST}:${PWD##${HOME}/}$ '
