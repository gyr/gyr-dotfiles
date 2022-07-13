##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   .bash_profile
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
# Update: 20100113 23:10:46
#
##################################


# Turn off TTY "start" and "stop" commands (they default to C-q and C-s,
# respectively, but Bash uses C-s to do a forward history search)
#stty start ''
#stty stop  ''
#or
#stty -ixon

#[[ -f /bin/zsh ]] && /bin/zsh -l
#[[ $SSH_TTY ]] && exit

[ -z "${GYR_PATH}" ] && . ~/.gyr.d/dotfiles/gyrprofile

# ~/.bash_profile: executed by the command interpreter for login shells.
# When this file is read by bash(1), ~/.bash_login and ~/.profile are not
# read.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile
#umask 022

# if running bash
if [ -n "${BASH_VERSION}" -a -t 0 ]; then
    # include .bashrc if it exists
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
    [ $SHLVL -eq 1 ] && linux_logo 2> /dev/null
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH="~/bin:$PATH"
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
