##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   .zlogin
# Update: 20100113 23:10:37
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
##################################


### START-Keychain ###
# Do not re-use ssh-agent's keys
# The --clear option make sure Intruder cannot use your existing SSH-Agents keys
# i.e. Only allow cron jobs to use password less login
if [ -f ~/.ssh/id_ecdsa ]; then
    if [ -x /usr/bin/keychain ]; then
        /usr/bin/keychain --clear
        [ -f ~/.keychain/${HOSTNAME}-sh ] && . ~/.keychain/${HOSTNAME}-sh
        [ -f ~/.keychain/${HOSTNAME}-sh-gpg ] && . ~/.keychain/${HOSTNAME}-sh-gpg
    fi
fi
### End-Keychain ###
#exec /usr/bin/ssh-agent ${SHELL}
#ssh-add
