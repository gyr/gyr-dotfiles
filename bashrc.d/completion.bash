################################################################################
#
# Author: Gustavo Yokoyama Ribeiro <gyr AT protonmail DOT ch>
# File:   completion.bash
# Update: 20150220
# (C) Copyright 2015 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
################################################################################

# enable completion
#if [ -f /etc/bash_completion ];then
#    shopt -s progcomp && . /etc/bash_completion
#fi
if shopt -q progcomp; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

[ -f /usr/share/doc/tmux/examples/bash_completion_tmux.sh ] && . /usr/share/doc/tmux/examples/bash_completion_tmux.sh

#[ -f ${GYR_PATH}/dotfiles/gyr_bash_completion ] && . ${GYR_PATH}/dotfiles/gyr_bash_completion

#HOSTFILE=$(grep '^Host\b' ${HOME}/.ssh/config | sed -e 's/Host //' -e 's/\*//' | perl -pe 's/^M//' | perl -pe 's/\n/ /')
_compssh ()
{
    cur=${COMP_WORDS[COMP_CWORD]};
    COMPREPLY=($(compgen -W "$(grep '^Host\b' ${HOME}/.ssh/config | sed -e 's/Host //' -e 's/\*//' | perl -pe 's/^M//' | perl -pe 's/\n/ /')" -- $cur))
    #COMPREPLY=($(compgen -W "$(grep '^Host\b' ${HOME}/.ssh/config | sed -e 's/Host //')" -- $cur))
    #COMPREPLY=($(compgen -W '$(cat ${HOME}/.ssh/config | grep "^Host\b" - | sed -e "s/Host //")' -- $cur))
    #COMPREPLY=($(compgen -W "$(grep \"^Host\" ~/.ssh/config |cut -f 2 -d \" \" | perl -pe \"s/^M//\" | perl -pe \"s/\n/ /\") –all –schema" – $cur))
}
complete -A hostname cssh
complete -F _compssh cssh
complete -A hostname mosh
complete -F _compssh mosh
complete -A hostname sshtmp
complete -F _compssh sshtmp
complete -A hostname scptmp
complete -F _compssh scptmp
#complete -F _known_hosts gyr-autossh
#complete -F _compssh ssh
#complete -F _ssh gyr-autossh

# Bash Completion
#to list all completion: complete -p
#complete -W "`awk '{ print $2 }' /etc/hosts`" ssh
#complete -cf sudo
#complete -cf gksu
complete -d cd

# Alias names
complete -A alias unalias

# Bash builtins
complete -A builtin builtin

# Bash options
complete -A setopt set

# Commands
complete -A command command complete coproc exec hash type

# Directories
complete -A directory cd pushd mkdir rmdir

# Functions
complete -A function function

# Help topics
complete -A helptopic help

# Jobspecs
complete -A job disown fg jobs
complete -A stopped bg

# Readline bindings
complete -A binding bind

# Shell options
complete -A shopt shopt

# Signal names
complete -A signal trap

# Variables
complete -A variable declare export readonly typeset

# Both functions and variables
complete -A function -A variable unset

if hash fzf 2> /dev/null; then
    if [ -f /usr/share/bash-completion/completions/fzf ]; then
        . /usr/share/bash-completion/completions/fzf
    fi
    if [ -f /usr/share/bash-completion/completions/fzf-key-bindings ]; then
        . /usr/share/bash-completion/completions/fzf-key-bindings
    fi
    export FZF_DEFAULT_OPS="--extended --hidden --follow"
    if hash fd; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        # To apply the command to CTRL-T as well
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        # To apply the command to ALT-C
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    fi
    _fzf_setup_completion host autossh
fi

# vim: set filetype=sh fileformat=unix foldmethod=indent
