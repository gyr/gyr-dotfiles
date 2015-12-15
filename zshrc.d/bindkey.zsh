################################################################################
#
# Author: Gustavo Yokoyama Ribeiro <gyr AT protonmail DOT ch>
# File:  bindkey.zsh
# Update: 20151015
# (C) Copyright 2015 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
################################################################################

source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}

bindkey -v
bindkey -M viins '^S' copy-prev-shell-word
bindkey '^Q' push-line # push current command into a buffer, allows you to do another command then returns to previous command
bindkey "^P" vi-up-line-or-history
bindkey "^N" vi-down-line-or-history
# completion in the middle of a line
bindkey '^I' expand-or-complete-prefix
# ctrl-L pipes to less
#bindkey -s '^L' "|less\n"
# ctrl-B runs it in the background
#bindkey -s '^B' "&\n"
#_history-complete-{older,newer} is the same as bash dabbrev-expand

autoload zkbd
function zkbd_file() {
    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
    return 1
}

[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
keyfile=$(zkbd_file)
ret=$?
if [[ ${ret} -ne 0 ]]; then
    zkbd
    keyfile=$(zkbd_file)
    ret=$?
fi
if [[ ${ret} -eq 0 ]] ; then
    . "${keyfile}"
else
    printf "Failed to setup keys using zkbd.\n"
fi
unfunction zkbd_file; unset keyfile ret

# OR
## create a zkbd compatible hash;
## to add other keys to this hash, see: man 5 terminfo
#typeset -A key
#
#key[Home]=${terminfo[khome]}
#key[End]=${terminfo[kend]}
#key[Insert]=${terminfo[kich1]}
#key[Delete]=${terminfo[kdch1]}
#key[Up]=${terminfo[kcuu1]}
#key[Down]=${terminfo[kcud1]}
#key[Left]=${terminfo[kcub1]}
#key[Right]=${terminfo[kcuf1]}
#key[PageUp]=${terminfo[kpp]}
#key[PageDown]=${terminfo[knp]}
#
#for k in ${(k)key} ; do
#    # $terminfo[] entries are weird in ncurses application mode...
#    [[ ${key[$k]} == $'\eO'* ]] && key[$k]=${key[$k]/O/[}
#done
#unset k

#. ~/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" vi-forward-blank-word
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" vi-backward-blank-word
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char

rationalise-dot()
{
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# vim: set filetype=sh fileformat=unix foldmethod=indent
