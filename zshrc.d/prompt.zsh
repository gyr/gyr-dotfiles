################################################################################
#
# Author: Gustavo Yokoyama Ribeiro <gyr AT protonmail DOT ch>
# File:  prompt.zsh
# Update: 20151015
# (C) Copyright 2015 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
################################################################################

# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#SEC273

autoload -Uz vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable hg git bzr svn cvs

precmd()
{
    # Clear previous CMD in screen
    if [[ "${TERM}" =~ "screen*" ]]; then
        print -nR $'\033k'''$'\033'\\
        print -nR $'\033]0;'$'\a'
    fi
    # Git Prompt
    #if which git > /dev/null 2>&1; then
    #    local PR_GIT_STATUS=$([[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*")
    #    PR_GIT=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/<\1${PR_GIT_STATUS}>/")
    #fi
    # Mercurial prompt
    #if which hg > /dev/null 2>&1; then
    #    if [ "$(hg root 2> /dev/null)" ]; then
    #        local HG_PROMPT_STATUS=$(hg status 2> /dev/null | cut -c1 | uniq | paste -s -d'|')
    #        PR_HG=$(hg branch 2> /dev/null | sed -e "s/\(.*\)/<\1|${HG_PROMPT_STATUS}|>/")
    #    else
    #        PR_HG=""
    #    fi
    #fi
    local GIT_SHA=$(git rev-parse --short HEAD 2>/dev/null)
    if [[ ! -z "$(git ls-files --other --exclude-standard 2> /dev/null)" ]]; then
        local GIT_UNTRACK='u'
    fi
    if [[ ! -z "$(git stash list 2> /dev/null)" ]]; then
        local GIT_STASH='s'
    fi
    zstyle ':vcs_info:git*' formats "(%s)-[%b|${GIT_SHA}]${GIT_UNTRACK}${GIT_STASH}%m%u%c"
    zstyle ':vcs_info:git*' actionformats "(%s)-[%b|${GIT_SHA}|%a]${GIT_UNTRACK}${GIT_STASH}%m%u%c"
    if [ "$(hg root 2> /dev/null)" ]; then
        local HG_PROMPT_STATUS=$(hg status 2> /dev/null | cut -c1 | uniq | paste -s -d'|')
        zstyle ':vcs_info:hg:*' formats "(%s:%b|%c%u|${HG_PROMPT_STATUS})"
    fi
    vcs_info
    PR_GIT="${vcs_info_msg_0_}"

    if [[ ${ZSH_VERSION} > 3.0.8 ]]; then
        local TERMWIDTH=${COLUMNS}

        # Truncate the path if it's too long.
        PR_FILLBAR=""
        PR_PWDLEN=""

        local ccsize=${#${PR_CC_VIEW_NAME}}
        local gitsize=${#${PR_GIT}}
        local hgsize=${#${PR_HG}}
        local reposize=$(($ccsize + $gitsize + $hgsize))

        local promptsize=${#${(%):-[]}}
        local pwdsize=${#${(%):-%~}}
        local PR_HBAR="-"

        if [[ "$promptsize + $pwdsize + $reposize" -gt $TERMWIDTH ]]; then
            PR_PWDLEN=$(($TERMWIDTH - $promptsize - $reposize))
        else
            PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize + $reposize)))..${PR_HBAR:-_}.)}"
        fi
    fi
}


preexec()
{
    if [[ "${TERM}" =~ "screen*" ]]; then
        print -nR $'\033k'$1$'\033'\\
        print -nR $'\033]0;'$2$'\a'
    fi
}

# If I am using vi keys, I want to know what mode I am currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
# http://www.jukie.net/~bart/conf/zsh.d/S60_prompt
function zle-line-init zle-keymap-select {
    PR_VI_MODE="${${KEYMAP/vicmd/-COMMAND-}/(main|viins)/}"
    #PR_VI_COLOR="${${KEYMAP/vicmd/cyan}/(main|viins)/black}"
    PR_VI_COLOR="${${KEYMAP/vicmd/white}/(main|viins)/black}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


setprompt()
{
    setopt noxtrace localoptions

    [[ -z "$(functions zsh/terminfo)" ]] && autoload -Uz zsh/terminfo
    # see in feature releases : man zshcontrib | less -p vcs_info

    # set a simple variable to show when in screen
    local PR_SCREEN=""
    if [[ -n "${WINDOW}" ]]; then
        PR_SCREEN="[${WINDOW}]"
    fi

    # Finally, the prompt.
    if [[ ${ZSH_VERSION} > 3.0.8 ]]; then
        # Decide if we need to set titlebar text.
        case ${TERM} in
        xterm*)
            local PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ ${PR_CC_VIEW_NAME}${PR_GIT}${PR_HG} | ${COLUMNS}x${LINES} | %y\a%}'
        ;;
        screen*)
            local PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ ${PR_CC_VIEW_NAME}${PR_GIT}${PR_HG} | ${COLUMNS}x${LINES} | %y\e\\%}'
        ;;
        *rxvt*)
            local PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
        ;;
        *)
            local PR_TITLEBAR=""
        ;;
        esac

        case "$(hostname)" in
            'tegu')
                PR_PRE='%{$fg[red]%}'
            ;;
            'godzilla'|'shenlong')
                PR_PRE='%{$fg[green]%}'
            ;;
            'zok'|'ghidorah')
                #PR_PRE=${PR_YELLOW}
                PR_PRE='%{$fg[yellow]%}'
            ;;
            'smaug'|'tiamat')
                PR_PRE='%{$fg[cyan]%}'
            ;;
            *)
                PR_PRE='%{$fg[magenta]%}'
            ;;
        esac
        if [[ "${TERM}" =~ "linux*" ]]; then
            local PR_PATH='(%${PR_PWDLEN}<..<%~%<<)'
            local PR_BASE='%(!.%SROOT%s.%n)@%m${PR_CC_VIEW_NAME}${PR_GIT}${PR_HG}'"${PR_SCREEN}"'%# '
        else
            #local PR_PATH='${PR_SET_CHARSET}(%${PR_PWDLEN}<..<%~%<<)${PR_SHIFT_IN}${(e)PR_FILLBAR}${PR_SHIFT_OUT}${PR_CC_VIEW_NAME}${PR_GIT}${PR_HG}'
            #local PR_BASE='%(!.%SROOT%s.%n)@%m'"${PR_SCREEN}"'%# '
            local PR_PATH='(%(!.%SROOT%s.%n)@%m:%${PR_PWDLEN}<..<%~%<<)${PR_SHIFT_IN}${(e)PR_FILLBAR}${PR_SHIFT_OUT}${PR_CC_VIEW_NAME}${PR_GIT}${PR_HG}'
            local PR_BASE="${PR_SCREEN}"'%# '
        fi
        local PR_POST='%{$reset_color%}'

        PROMPT="${(e)PR_TITLEBAR}${PR_PRE}${PR_PATH}${PR_BASE}${PR_POST}"
        RPROMPT='%{$fg[black]%}%(0?..%{$bg[red]%}-%?-)%(1j.%{$bg[yellow]%}[%j].)%{$bg[${PR_VI_COLOR}]%}${PR_VI_MODE}%{$reset_color%}'
    else
        PS1='${PR_CC_VIEW_NAME}${PR_GIT}${PR_HG}'"%m:%~%# "
    fi

    # PS2 is the continuation prompt. %_ shows the reason the continuation prompt is being displayed.
    PS2="%{$fg[cyan]%}(%_)%{$reset_color%}"
}

setprompt

# vim: set filetype=sh fileformat=unix foldmethod=indent
