##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   aliases.bash
# Update: 20150220 10:41:45
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
##################################

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi
#alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//" -e "s/\s*A$//"'
#alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[$?] $(alert_helper)"'
#alias alert='notify-send -i gnome-terminal "[$?] $(alert_helper)"'
alias gyr-alert-sh='notify-send -i gnome-terminal "[$?] $(history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//;s/;\s*gyr-alert-sh$//")"'
#alias talert='alert_helper|wall'
alias tshalert='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//;s/;\s*tshalert$//"|wall'

# vim: set filetype=sh fileformat=unix foldmethod=indent
