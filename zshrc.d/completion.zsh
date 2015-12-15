################################################################################
#
# Author: Gustavo Yokoyama Ribeiro <gyr AT protonmail DOT ch>
# File:  completion.zsh
# Update: 20151015
# (C) Copyright 2015 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
################################################################################

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

# vim: set filetype=sh fileformat=unix foldmethod=indent
