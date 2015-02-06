##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   .zshrc
# Update: 20100823 01:52:05
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
##################################


###################
#                 #
#  COMMON SHELL   #
#                 #
###################
[ -f ${GYR_PATH}/dotfiles/gyrrc ] && . ${GYR_PATH}/dotfiles/gyrrc


###################
#                 #
#    VARIABLES    #
#                 #
###################

export SHELL=$(which zsh)
export INPUTRC=${GYR_PATH}/dotfiles/inputrc
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zshistory
export BROWSER=firefox
export VIEWER=gpicview
# BUG fix for OpenOffice
export OOO_FORCE_DESKTOP=gnome
export ZLS_COLORS=${LS_COLORS}
## Anti-aliasing in the two toolkits (from resolve)
## Use this type of assignment to set the variable if not already set
(( ${+QT_XFT} )) || export QT_XFT=1
(( ${+GDK_USE_XFT} )) || export GDK_USE_XFT=1

# Set man path
manpath=(/usr/man /usr/share/man /usr/local/share/man /usr/local/man)
# Add .gyr.d to the target directorries
#cdpath=($cdpath . ${HOME}/.gyr.d)
#typeset -U cdpath


###################
#                 #
#      ALIAS      #
#                 #
###################
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
hash -d wgyr=/work/gyr
hash -d gyrd=/work/gyr/.gyr.d
hash -d wtmp=/work/tmp


###################
#                 #
#   COMPLETION    #
#                 #
###################

# zshex
# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate _match _list _oldlist _prefix
#zstyle ':completion:*' format '%UCompleting %d%u'
zstyle ':completion:*' group-name ''
# command will never select the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*' ignore-parents parent pwd .. directory
# add colors to completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '+' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' menu select=0
zstyle ':completion:*' preserve-prefix '//[^/]##/'
#zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
#zstyle ':completion:*' special-dirs true
# Remove trailing slashes. If you end up using a directory as argument, this will remove the trailing slash (usefull in ln)
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/gyr/.zshrc'

autoload -Uz compinit && compinit
# End of lines added by compinstall
if [[ ${ZSH_VERSION} > 3.0.8 ]]; then

    ###
    # See if we can use colors (more info: man zshcontrib)
    # usage %{$_%}
    # http://zshwiki.org/home/config/prompt
    autoload -U colors && colors

    # This allows incremental completion of a word.
    # After starting this command, a list of completion
    # choices can be shown after every character you
    # type, which you can delete with ^h or DEL.
    # RET will accept the completion so far.
    # You can hit TAB to do normal completion, ^g to
    # abort back to the state when you started, and ^d to list the matches.
    #autoload -U incremental-complete-word
    #zle -N incremental-complete-word
    #bindkey "^Xi" incremental-complete-word ## C-x-i

    # This function allows you type a file pattern,
    # and see the results of the expansion at each step.
    # When you hit return, they will be inserted into the command line.
    #autoload -U insert-files
    #zle -N insert-files
    #bindkey "^Xf" insert-files ## C-x-f

    # This set of functions implements a sort of magic history searching.
    # After predict-on, typing characters causes the editor to look backward
    # in the history for the first line beginning with what you have typed so
    # far.  After predict-off, editing returns to normal for the line found.
    # In fact, you often don't even need to use predict-off, because if the
    # line doesn't match something in the history, adding a key performs
    # standard completion - though editing in the middle is liable to delete
    # the rest of the line.
    autoload -U predict-on
    zle -N predict-on
    #zle -N predict-off
    bindkey "^Xx" predict-on ## C-x-x
    bindkey "^X^X" predict-off ## C-x C-x

    # For convenience, zsh also includes a function to setup some suffix
    # aliases for you automatically. The function is named zsh-mime-setup(),
    # and it uses the common mime.types and mailcap files to find associations
    # between file types and programs.
    # If this works, run alias –s to see the list of suffix aliases that have
    # been defined. (For more information, read the zshcontrib man page.)
    autoload –U zsh-mime-setup
    zsh-mime-setup

    # Load zmv
    #autoload -U zmv

    # Load zargs
    # To remove all the ~ files recursively and prevent rm to have to many arguments :
    # zargs **/*~ -- rm
    #autoload -U zargs

    #autoload      edit-command-line
    #zle -N        edit-command-line
    #bindkey '^B' edit-command-line

    # AUTOCOMPLETION
    # complist module
#    zmodload -i zsh/complist
#    zmodload -i zsh/mapfile
#    zmodload -i zsh/mathfunc
#    zmodload -i zsh/complete
#    The -a option isn't absolutely necessary, but keeps you from having to remember to type:
#    "zmodload zsh/complist" and "autoload colors"
    zmodload -a colors
    zmodload -a autocomplete
    zmodload -a complist

#    zstyle ':completion:*' show-completer

    # ... unless we really want to.
    zstyle '*' single-ignored show

    # enable cache
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path ~/.zsh/cache

    # when completing inside array or association subscripts, the array elements are more useful than parameters so complete them first:
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # Picking parameters by the existence of a special completer
    # in recent zsh 4.1.x only: complete the names of parameters we have special completions for in parameter assignments:
    zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

    # General completion technique
    # complete as much u can ..
    zstyle ':completion:incremental:*' completer _complete _correct

    # normal completion is nice; sometimes, when I'm misspelling
    # something, the zsh should assists in finding the correct words
    # '-e' is needed to get the argument evaluated each time this is called
    # this argument to max-errors allows one error in 3 characters.
    # found in 'From Bash to Z Shell' Chapter 10 - great book, btw :)
    # '-e' was added in 4.0
    # allow one error for every three characters typed in approximate completer
    zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

#    zstyle ':completion:*' expand 'yes'
#    zstyle ':completion:*' expand prefix suffix

#    # Using _expand before _complete
#    zstyle ':completion:all-matches::::' completer _all_matches _complete
#    zstyle ':completion:all-matches:*' old-matches true
#    zstyle ':completion:all-matches:*' insert true
#    zstyle ':completion:match-word::::' completer _all_matches _match _ignored
#    zstyle ':completion:match-word:*' insert-unambiguous true
#    zstyle ':completion:match-word:*' match-original both
#    zle -C all-matches complete-word _generic
#    zle -C match-word complete-word _generic

#    # insert all expansions for expand completer
#    zstyle ':completion:*:expand:*' tag-order all-expansions

#    # ignore completion functions (until the _ignored completer)
#    zstyle ':completion:*:functions' ignored-patterns '_*'

    # don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

    # filename suffixes to ignore during completion (except after rm command)
    zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.(o|c~|zwc)' '*~'

    # Messages/warnings format
    zstyle ':completion:*:descriptions' format "%{${fg[cyan]}%}%B%U---- %d%u%b%{${reset_color}%}"
    zstyle ':completion:*:messages' format "%{${fg[cyan]}%}%B%U---- %d%u%b%{${reset_color}%}"
    zstyle ':completion:*:warnings' format "%{${fg[cyan]}%}%B---- No matches for: %d%b%{${reset_color}%}"
    zstyle ':completion:*:corrections' format "%{${fg[cyan]}%}- %d - (errors %e)%{${reset_color}%}"
    zstyle ':completion:*:default' select-prompt "%{${fg[black]}%}%{${bg[cyan]}%}Match %m  Line %l  %p%{${reset_color}%}"
#    zstyle ':completion:*:default' list-prompt "Line %l  Continue?"
    # manual pages are sorted into sections
    zstyle ':completion:*:manuals' separate-sections true
    zstyle ':completion:*:manuals.(^1*)' insert-sections true

    # Describe options in full
    ###zstyle ':completion:*:options' description 'yes'
    ###zstyle ':completion:*:options' auto-description '%d'

    # auto-complete list groups
    # Separate matches into groups
#    zstyle ':completion:*:matches' group 'yes'
#    zstyle ':completion:*' list-grouped
#    zstyle ':completion:*:*:-command-:*' group-order commands builtins

    # Ignoring lost+found directories
    zstyle ':completion:*:cd:*' ignored-patterns '(*/)#lost+found'

    # Ignore what's already in the line
    zstyle ':completion:*:(rm|cp|mv||kill|diff|vim|cat|less|more|gzip|gunzip|zcat|tar|fg|bg):*' ignore-line yes

    # users completer add lots of uninteresting user accounts, remove them
    #zstyle ':completion:*:*:*:users' ignored-patterns \
    #    adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
    #    named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
    #    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup  bind  \
    #    dictd  gnats  identd  irc  man  messagebus  postfix  proxy  sys  www-data \
    #    Debian-exim list
    users=(root gyr gustavoyr gutoyr)
    zstyle ':completion:*' users $users


    # completions for some progs. not in default completion system
    #compdef '_files -g "*.[gG][zZ]"' gunzip zcat
    zstyle ':completion:*:*:(gunzip|zcat):*' file-patterns '*.(gz|GZ):gz\ files *(-/):directories'
    zstyle ':completion:*:*:(bunzip2|bzcat):*' file-patterns '*.(bz2|BZ2):bzip2\ files *(-/):directories'
    zstyle ':completion:*:*:(unzip):*' file-patterns '*.(zip|ZIP):zip\ files *(-/):directories'
    zstyle ':completion:*:*:(mpg321|mpg123):*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
    #zstyle ':completion:*:*:mpg123:*' file-patterns '(#i)*.mp3:files:mp3\ files *(-/):directories:directories'
    zstyle ':completion:*:*:(evince):*' file-patterns '*.(pdf|PDF|ps|PS):pdf\ files *(-/):directories'
    zstyle ':completion:*:*:(soffice):*' file-patterns \
        '*.(rtf|doc|xls|ppt|odt|ods|odp):office\ files *(-/):directories'
    zstyle ':completion:*:*:(eog):*' file-patterns \
        '*.(gif|GIF|jpg|JPG|png|PNG|pcx|PCX|tif|TIF):pic\ files *(-/):directories'

    # generic completions for programs which understand GNU long options(--help)
    compdef _gnu_generic slrnpull make df du mv cp tar rm ls cut diff grep head tail tee less more cat ln

#    # PID auto-complete (kill)
#    zstyle ':completion:*:*:kill:*' menu yes select
#    zstyle ':completion:*:kill:*' force-list always

#    # process completion
#    zstyle ':completion:*:*:*:*:processes' menu yes select
#    zstyle ':completion:*:*:*:*:processes' force-list always
#    # on processes completion complete all user processes
#    zstyle ':completion:*:processes' command 'ps -fu$USER'

#    # 1. All /etc/hosts hostnames are in autocomplete
#    # 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    #    then foobar.domain will show up in autocomplete!
#    local _gyrhosts=('ocdc.hursley.ibm.com' '9.8.234.189')
#    zstyle ':completion:*:*:*' hosts $_gyrhosts
#    zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
#    compdef _hosts ssh ftp telnet scp sft

    # determine in which order the names (files) should be
    # listed and completed when using menu completion.
    # `size' to sort them by the size of the file
    # `links' to sort them by the number of links to the file
    # `modification' or `time' or `date' to sort them by the last modification time
    # `access' to sort them by the last access time
    # `inode' or `change' to sort them by the last inode change time
    # `reverse' to sort in decreasing order
    # If the style is set to any other value, or is unset, files will be
    # sorted alphabetically by name.
    zstyle ':completion:*' file-sort name

#    # case-insensitive (uppercase from lowercase) completion
#    #zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#    # case-insensitive (all) completion
#    ###zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
#    # case-sensitive auto-complete
#    #zstyle ':completion:*:complete:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#    # case-insensitive,partial-word and then substring completion
#    #zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#    # auto-complete with wildcard
#    zstyle ':completion:*:complete-extended:*' matcher 'r:|[.,_-]=* r:|=*'

#    # add specific completion for commands
#    # _f() { compadd one two three } ; compdef _f f
#    _completeviews()
#    {
#        local _gyrviews
#        _gyrviews=($(cleartool lsview -s | grep ${USER}))
#        compadd $_gyrviews
#    }
#    compdef _completeviews setcs catcs setview rmView scsv mkview clearView clearPriv cleanview.pl mkviewlj sv getView lsv bldCmd
fi

###################
#                 #
#     BINDKEY     #
#                 #
###################
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


###################
#                 #
#      PROMPT     #
#                 #
###################
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
    if [[ -z "$(git ls-files --other --exclude-standard 2> /dev/null)" ]]; then
        zstyle ':vcs_info:git*:*' formats '(%s)-[%b%c%u]'
    else
        zstyle ':vcs_info:git*:*' formats '(%s)-[%b%c%u*]'
    fi
    if [ "$(hg root 2> /dev/null)" ]; then
        local HG_PROMPT_STATUS=$(hg status 2> /dev/null | cut -c1 | uniq | paste -s -d'|')
        zstyle ':vcs_info:hg:*' formats "(%s)-[%b%c%u|${HG_PROMPT_STATUS}]"
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
        local PR_HBAR="_"

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

        local PR_PRE='%{$fg[white]%}'
        #local PR_PRE='%{$fg_bold[black]%}'
        case "$(hostname)" in
            'zero')
                PR_PRE='%{$fg[red]%}'
            ;;
            'cataclysm')
                PR_PRE='%{$fg[green]%}'
            ;;
            'ocdc')
                #PR_PRE=${PR_YELLOW}
                PR_PRE='%{$fg[cyan]%}'
            ;;
            'nimbus'|'cumulus')
                PR_PRE='%{$fg[blue]%}'
            ;;
            'stratus')
                #PR_PRE=${PR_CYAN}
                PR_PRE='%{$fg[yellow]%}'
            ;;
            'altus'|'cirrus')
                PR_PRE='%{$fg[magenta]%}'
            ;;
            *)
                #PR_PRE=${PR_LIGHT_BLACK}
                PR_PRE='%{$fg[white]%}'
            ;;
        esac
        if [[ "${TERM}" =~ "linux*" ]]; then
            local PR_PATH='(%${PR_PWDLEN}<..<%~%<<)'
            local PR_BASE='%(!.%SROOT%s.%n)@%m${PR_CC_VIEW_NAME}${PR_GIT}${PR_HG}'"${PR_SCREEN}"'%# '
        else
            local PR_PATH='${PR_SET_CHARSET}(%${PR_PWDLEN}<..<%~%<<)${PR_SHIFT_IN}${(e)PR_FILLBAR}${PR_SHIFT_OUT}${PR_CC_VIEW_NAME}${PR_GIT}${PR_HG}'
            local PR_BASE='%(!.%SROOT%s.%n)@%m'"${PR_SCREEN}"'%# '
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


# exemplo:
#######
#
# test if a parameter is numeric
#  $ if [[ $1 == <-> ]] ; then
#         echo numeric
#    else
#         echo non-numeric
#    fi

# For Glob Qualifiers, i.e. print -l /**/*(*.m-1)
# man zshexpn

# Other interesting man pages:
# man zshall
# man zshbuiltins
# man zshmisc
