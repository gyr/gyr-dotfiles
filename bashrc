##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   .bashrc
# Update: 20100401 10:45:23
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
##################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# or
#[[ $- != *i* ]] && return

###################
#                 #
#    VARIABLES    #
#                 #
###################
# Source .bashrc for non-interactive Bash shells
export BASH_ENV=~/.bashrc
export SHELL=$(type -P bash)
export INPUTRC=${GYR_PATH}/dotfiles/inputrc
[ 'linux' = "${TERM}" ] && TERM=linux-16color

#if [ -f "${HOME}/.gpg-agent-info" ]; then
#    . "${HOME}/.gpg-agent-info"
#    export GPG_AGENT_INFO
#    export SSH_AUTH_SOCK
#fi
CDPATH=.:${GYR_PATH}:${CDPATH}

# If you are a developer, uncomment the following to make sure core dumps
# will be generated when they should be
#ulimit -c unlimited

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# ignore dups, lines started with space and erase dups
HISTCONTROL=ignoreboth:erasedups

# Do *not* append the following to our history: consecutive duplicate
# commands(& pattern), command starting with a space([ \t]* pattern), ls, bg and fg,exit, etc.
# Don't keep useless history commands. Note the last pattern is to not
# keep dangerous commands in the history file.  Who really needs to
# repeat the shutdown(8) command accidentally from your command
# history?
#HISTIGNORE='\&:&:[ \t]*:ls:[fb]g:exit:pwd:cd ..:cd ~-:cd -:cd:jobs:set -x:ls -l:ls -l:l:ll:ls:la:lla:lt'
HISTIGNORE="&:ls:[fb]g:exit:pwd::cd -:cd:jobs:l:ll:ls:la:lla:lt:popd:reboot:halt:shutdown*:?:??"
#HISTIGNORE=${HISTIGNORE}':%1:%2:popd:top:pine:mutt:shutdown*'

# Turn off any filesize restrictions
#export HISTFILESIZE=10000
unset HISTFILESIZE
HISTSIZE=100000


###################
#                 #
#     OPTIONS     #
#                 #
###################
# Bash autocomplete case insensitive search
shopt -s nocaseglob
# an argument to the cd builtin command that is not a directory is assumed to be the name of a variable whose value is the directory to change to.
shopt -s cdable_vars
# correct minor spelling erros in a cd command.
shopt -s cdspell
# This option mostly keeps you from needing to run "hash -r" when you modify directories in your path
shopt -s checkhash
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize
# append multi-line commands in history as a single line command.
shopt -s cmdhist
# allow . files be returned in path-name expansion.
shopt -s dotglob
# extend pattern match.
shopt -s extglob
# the history list is appended when the shell exits, rather than overwriting the file.
shopt -s histappend
# allows you to audit the command as expanded before you enter it
shopt -s histverify
# [DISABLE] multi-line commands are saved to the history with embedded newlines rather than using semicolon separators where possible.
shopt -u lithist
if [ "${GYR_OS}" != 'Darwin' ]; then
    # If a command is just a directory name, it cd's into that directory.
    shopt -s autocd
fi
# Hostname expansion
#shopt -s hostcomplete

if (( $BASH_VERSINFO >= 4 ));then
    # Checks for running/stopped jobs before exit shell
    shopt -s checkjobs
    # attempts spelling corrention on directory names during completion
    shopt -s dirspell
    # the globbing code treats `**' specially -- it matches all directories (and files within them, when appropriate) recursively.
    shopt -s globstar
fi

########
# sets input line and text editors
set -o vi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#if [ -n "${DISPLAY}" ]; then
#    #[ -n "$WINDOWID" ] && [[ "${TERM}" =~ .*screen.* ]] && xprop -frame -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY 0xf0000000 -id ${WINDOWID}
#    #[[ "${TERM}" =~ .*screen.* ]] && TRANSPARENCY='0xf0000000' || TRANSPARENCY='0xd0000000'
#    TRANSPARENCY='0xd0000000'
#    xprop -frame -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY ${TRANSPARENCY} -id ${WINDOWID}
#    unset TRANSPARENCY
#fi
#if [ "$PS1" ] ; then
#    if [ -d /dev/cgroup/cpu/user/ ]; then
#        mkdir -p -m 0700 /dev/cgroup/cpu/user/$$ > /dev/null 2>&1
#        echo $$ > /dev/cgroup/cpu/user/$$/tasks
#        echo "1" > /dev/cgroup/cpu/user/$$/notify_on_release
#    fi
#fi

###################
#                 #
#  COMMON SHELL   #
#                 #
###################
[ -z "${GYR_PATH}" ] && export GYR_PATH=${HOME}/.gyr.d
[ -f ${GYR_PATH}/dotfiles/gyrrc ] && . ${GYR_PATH}/dotfiles/gyrrc

# Load any supplementary scripts
if [ -d ${GYR_PATH}/dotfiles/bashrc.d ] ; then
    for config in "${GYR_PATH}"/dotfiles/bashrc.d/*.bash ; do
        source "$config"
    done
fi
unset -v config

# vim: set filetype=sh fileformat=unix foldmethod=indent
