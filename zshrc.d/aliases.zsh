##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   aliases.zsh
# Update: 20151015 09:13:05
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
##################################

alias lsd='ls -d *(/)' # list just directories *N*
#alias lsd='ls -d *(-/DN)'
alias lsl='ls *(@)' # list just links
alias lsf='ls *(.)' # list just regular files *N*
alias lsn='ls -l *(om[1])' # list newest file
alias lso='ls -l *(Om[1])' # list oldest file
alias dirs='dirs -v'
alias time='/usr/bin/time -p'
alias gyr-alert-sh='notify-send -i gnome-terminal "[$?] $(tail -n1 $HISTFILE | sed -e "s/^:\s*[0-9]\+:[0-9]\+;//" -e "s/;\s*gyr-alert-sh$//")"'

#alias -g R=' &; jobs | tail -1 | read A0 A1 A2 cmd; echo "running $cmd"; fg "$cmd"; zenity --info --text "$cmd done"; unset A0 A1 A2 cmd'
alias -g A='; notify-send -i gnome-terminal "[$?] $(tail -n1 $HISTFILE | sed -e "s/^:\s*[0-9]\+:[0-9]\+;//" -e "s/\s\+A$//")"'
alias -g CA="2>&1 | cat -A"
alias -g DN='> /dev/null'
alias -g G='|grep'
alias -g H='|head'
alias -g HL='--help'
alias -g L='|less'
alias -g LL="2>&1 | less"
alias -g M='|most'
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g ND='*(/om[1])' # newest directory
alias -g NF='*(.om[1])' # newest file
alias -g T='|tee'
alias -g S='|sort'
alias -g V='|vim -'
alias -g W='|wc -l'
alias -g X='|xargs'
alias -g Z='; notify-send !#:0'

alias -s pdf='evince'
alias -s {rtf,doc,odt,xls,ods,ppt,odp}='soffice'
alias -s {bz2,conf,gz,log,txt,diff,spec}=${EDITOR}
alias -s {gif,jpg,JPG,pcx,png,tif,htm,html}='xdg-open'
alias -s mp3='mpg123'

# 'cd ~cmus' to cd to /usr/src/cmus, for example
hash -d wtmp=/home/gyr/work/tmp

# vim: set filetype=sh fileformat=unix foldmethod=indent
