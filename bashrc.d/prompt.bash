################################################################################
#
# Author: Gustavo Yokoyama Ribeiro <gyr AT protonmail DOT ch>
# File:   prompt.bash
# Update: 20181129
# (C) Copyright 2015 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
################################################################################

function gyr_prompt
{
    # Reverse color
    #local PR_REV_RED="\[\e[0;41;30m\]"
    local PR_REV_RED='\[\033[0;41;30m\]'
    local PR_REV_GREEN='\[\033[0;42;30m\]'
    local PR_REV_YELLOW='\[\033[0;43;30m\]'
    local PR_REV_BLUE='\[\033[0;44;30m\]'
    local PR_REV_MAGENTA='\[\033[0;45;30m\]'
    local PR_REV_CYAN='\[\033[0;46;30m\]'
    local PR_REV_WHITE='\[\033[0;47;30m\]'
    # Regular color
    local PR_BLACK='\[\033[30m\]'
    #local PR_RED="\[\e[31m\]"
    local PR_RED='\[\033[31m\]'
    local PR_GREEN='\[\033[32m\]'
    local PR_YELLOW='\[\033[33m\]'
    local PR_BLUE='\[\033[34m\]'
    local PR_MAGENTA='\[\033[35m\]'
    local PR_CYAN='\[\033[36m\]'
    local PR_WHITE='\[\033[37m\]'
    # Bold color
    local PR_LIGHT_BLACK='\[\033[1;30m\]'
    #local PR_LIGHT_RED="\[\e[1;31m\]"
    local PR_LIGHT_RED='\[\033[1;31m\]'
    local PR_LIGHT_GREEN='\[\033[1;32m\]'
    local PR_LIGHT_YELLOW='\[\033[1;33m\]'
    local PR_LIGHT_BLUE='\[\033[1;34m\]'
    local PR_LIGHT_MAGENTA='\[\033[1;35m\]'
    local PR_LIGHT_CYAN='\[\033[1;36m\]'
    local PR_LIGHT_WHITE='\[\033[1;37m\]'
    # Underline color
    local PR_UNDER_BLACK='\[\033[4;30m\]'
    #local PR_UNDER_RED="\[\e[4;31m\]"
    local PR_UNDER_RED='\[\033[4;31m\]'
    local PR_UNDER_GREEN='\[\033[4;32m\]'
    local PR_UNDER_YELLOW='\[\033[4;33m\]'
    local PR_UNDER_BLUE='\[\033[4;34m\]'
    local PR_UNDER_MAGENTA='\[\033[4;35m\]'
    local PR_UNDER_CYAN='\[\033[4;36m\]'
    local PR_UNDER_WHITE='\[\033[4;37m\]'
    # Background color
    local PR_BACK_BLACK='\[\033[40m\]'
    #local PR_BACK_RED="\[\e[41m\]"
    local PR_BACK_RED='\[\033[41m\]'
    local PR_BACK_GREEN='\[\033[42m\]'
    local PR_BACK_YELLOW='\[\033[43m\]'
    local PR_BACK_BLUE='\[\033[44m\]'
    local PR_BACK_MAGENTA='\[\033[45m\]'
    local PR_BACK_CYAN='\[\033[46m\]'
    local PR_BACK_WHITE='\[\033[47m\]'
    # Reset color
    local PR_NO_COLOUR='\[\033[00m\]'

    if [ ! -z "${SCHROOT_CHROOT_NAME}" ]; then
        PR_CHROOT="(${SCHROOT_CHROOT_NAME})"
        local PR_COLOR=${PR_WHITE}
    elif [ "${GYR_OS}" = 'freebsd' ]; then
        local PR_COLOR=${PR_RED}
    elif [ "${GYR_OS}" = 'darwin' ]; then
        local PR_COLOR=${PR_LIGHT_BLACK}
    elif [ "${GYR_OS}" = 'debian' ]; then
        local PR_COLOR=${PR_MAGENTA}
    elif [ "${GYR_OS}" = 'rh' ]; then
        local PR_COLOR=${PR_BLUE}
    elif [ "${GYR_OS}" = 'suse' ]; then
        local PR_COLOR=${PR_GREEN}
    elif [ "${GYR_OS}" = 'arch' ]; then
        local PR_COLOR=${PR_CYAN}
    else
        local PR_COLOR=${PR_YELLOW}
    fi

    function promptCommand {

        # Last command status prompt
        # MUST be the first line of this function
        local LAST_COMMAND_STATUS=$?

        ########
        # Compartilhamento do historico do bash entre multiplas sessoes
        history -a

        [ ${LAST_COMMAND_STATUS} -ne 0 ] && LAST_COMMAND_PROMPT_STATUS="[${LAST_COMMAND_STATUS}]" || LAST_COMMAND_PROMPT_STATUS=''

        # Number of jobs
        JOB_NUMBER="$(jobs -s | wc -l | tr -d ' ' | sed 's/\([1-9]\+\)/\1/')"
        [ "${JOB_NUMBER}" != '0' ] && JOB_NUMBER="[${JOB_NUMBER}]" || JOB_NUMBER=''

        local DIR=$(pwd | sed -e "s:${HOME}:~:")
        local USER_HOST="${USER}@${HOSTNAME}:"
        local VIRTUALENV_PROMPT=''
        [ -n "${VIRTUAL_ENV}" ] && VIRTUALENV_PROMPT="(${VIRTUAL_ENV##*/}) "
        local PROMPT_SIZE=$((${#VIRTUALENV_PROMPT}+${#USER_HOST}+${#DIR}+${#LAST_COMMAND_PROMPT_STATUS}+2+${#JOB_NUMBER}+${#BATTERY}+10))
        local FILL_SIZE=$((${COLUMNS}-${PROMPT_SIZE}))
        ###FILL_LINE=''
        ###while [ "${FILL_SIZE}" -gt '0' ]
        ###do
        ###    FILL_LINE="${FILL_LINE}${zg1}"
        ###    FILL_SIZE=$((${FILL_SIZE}-1))
        ###done
        if [ "${FILL_SIZE}" -lt '0' ]
        then
            local CUT_LINE=$((3-${FILL_SIZE}))
            NEW_PWD="[${USER_HOST}...${DIR:${CUT_LINE}:${#DIR}}]"
            FILL_LINE=''
        else
            NEW_PWD="[${USER_HOST}${DIR}]"
            FILL_LINE='----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'
            FILL_LINE=${FILL_LINE:0:${FILL_SIZE}}
        fi
    }
    PROMPT_COMMAND=promptCommand

    if hash git 2> /dev/null; then
        export GIT_PS1_SHOWDIRTYSTATE=1
        # unstaged '*' and staged '+'
        export GIT_PS1_SHOWSTASHSTATE=1
        # stashed '$'
        export GIT_PS1_SHOWUNTRACKEDFILES=1
        # untracked files '%'
        export GIT_PS1_SHOWUPSTREAM='auto'
        # "=" neither ahead of nor behind the remote branch
        # "<" indicates you are behind,
        # ">" indicates you are ahead and
        # "<>"indicates you have diverged.
        export GIT_PS1_DESCRIBE_STYLE="branch"
    fi
    get_sha() {
        git rev-parse --short HEAD 2>/dev/null
    }

    local PR_PRE=
    local PR_PATH=${PR_COLOR}'${NEW_PWD}${FILL_LINE}'${PR_RED}'${LAST_COMMAND_PROMPT_STATUS}'${PR_YELLOW}'${JOB_NUMBER}'${PR_COLOR}'${BATTERY}''[\t]'
    [ $(id -u) -eq 0 ] && PR_COLOR=${PR_REV_WHITE}

    # Darwin
    if [ -e /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh ]; then
        source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
    # FreeBSD
    elif [ -e /usr/local/share/git-core/contrib/completion/git-prompt.sh ]; then
        source /usr/local/share/git-core/contrib/completion/git-prompt.sh
    # Fedora
    elif [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
        source /usr/share/git-core/contrib/completion/git-prompt.sh
    fi
    # SUSE and Debian sources git-prompt.sh out-of-the-box :)

    get_osc()
    {
        if [ -f .osc/_project ]; then
            echo "<<$(head -n 1 .osc/_project)>>"
        fi
    }

    if declare -F __git_ps1 &>/dev/null; then
        local PR_BASE=${PR_COLOR}${PR_CHROOT}'$(get_osc)''$(__git_ps1 "(%s $(get_sha))")'${PR_SCREEN}'\$'
    else
        local PR_BASE=${PR_COLOR}${PR_CHROOT}'$(get_osc)'${PR_SCREEN}'\$'
    fi
    local PR_POST=${PR_NO_COLOUR}' '

    PS1=${PR_PRE}${PR_PATH}'\n'${PR_BASE}${PR_POST}
    # improve shell debug
    export PS4=' ${BASH_SOURCE}:${LINENO}(${FUNCNAME[0]})\t '

    case ${TERM} in
        xterm*|*rxvt*)
            local TITLEBAR='\[\033]0;\u@\h:\w\007\]'
            PS1=${TITLEBAR}${PS1}
            ;;
        screen*)
            #local PS1S='\[\033k\033\\\]'
            #PS1=${PS1}${PS1S}
            PS1=${PS1}
            ;;
        linux*|vt220*)
            PS1=${PS1}
    esac
}

gyr_prompt

# vim: set filetype=sh fileformat=unix foldmethod=indent
