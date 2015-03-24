#!/bin/bash
##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   .xinitrc
# Update: 20100115 16:07:31
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
##################################

# Appending proggy font dir to font path
#if xset q > /dev/null 2>&1; then
#    [ -z $(xset q | grep "/home/gyr/.gyr.d/dotfiles/xfonts") ] && xset fp+ ${HOME}/.gyr.d/dotfiles/xfonts
#fi

# Applying X config
xrdb -merge ${HOME}/.gyr.d/dotfiles/Xdefaults && xrdb -load ${HOME}/.gyr.d/dotfiles/Xdefaults

# Set keyboard layout to US international (altgr key)
setxkbmap -layout us -variant altgr-intl

# Natural scroll (Disable caps_lock can be done here but setxkbmap described
# bellow is better)
xmodmap ${HOME}/.gyr.d/dotfiles/xmodmaprc
# OR
# Replace caps_lock to ESC
#setxkbmap -option caps:escape
# Replace caps_lock to CTRL-L
setxkbmap -option ctrl:nocaps

# Enable CTRL+ALT+BCKSPACE kill X
setxkbmap -option terminate:ctrl_alt_bksp

# Disable bell
xset b off
# or
#setterm -bfreq 0

# Set bind keys
xbindkeys

# Dual key config
xcape -e 'Control_L=Escape'

# Awesome WM
# Fix Java (GUI appears gray only)
#wmname LG3D

exit 0
# If debian exit
hash lsb_release 2> /dev/null && exit 0

# ONLY FOR XINITRC
# Disable lines below if session manager is been using!
#
#STARTUP="/usr/bin/startxfce4"
#STARTUP="/usr/bin/awesome"
#
case $1 in
    xfce4)
        STARTUP="/usr/bin/startxfce4"
        ;;
    e17)
        STARTUP="/usr/bin/enlightenment_start"
        ;;
    awesome)
        STARTUP="/usr/bin/awesome"
        ;;
    *)
        STARTUP="/usr/bin/awesome"
        ;;
esac

# test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
    # if not found, launch a new one
    STARTUP="/usr/bin/dbus-launch --sh-syntax --exit-with-session ${STARTUP}"
fi

# Start gpg-agent
killall gpg-agent
#gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info"

# Start ssh-agent
killall ssh-agent
#STARTUP="/usr/bin/ssh-agent ${STARTUP}"

# Window Manager
exec ck-launch-session ${STARTUP}
