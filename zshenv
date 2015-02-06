##################################
#
# Author: Gustavo Yokoyama Ribeiro
# File:   .zshenv
# Update: 20100203 10:53:45
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.
#
##################################


#[[ ${SHLVL} -eq 1 && ! -o login ]] && . ~/.gyr.d/dotfiles/zprofile

export DIRSTACKSIZE=256
# Disable email checking
unset mailpath

autoload -U is-at-least

unsetopt all_export                     # define = export
setopt   auto_cd                        # change to dirs without cd
setopt   auto_pushd                     # auto push directories
setopt   bare_glob_qual                 # () is qualifier list
unsetopt beep                           # i hate beeps
#setopt   beep
setopt   bg_nice                        # lower priority of bg jobs
setopt   brace_ccl                      # foo{ab} -> fooa foob
unsetopt bsd_echo                       # builtin echo works like in BSD
is-at-least 3.0.8 && setopt c_bases     # Output hexadecimal with 0x, understand 12#120 as 120 in base 12
setopt   case_glob                      # case sensitive globbing
setopt   cdable_vars                    # avoid the need for an explicit $
unsetopt chase_dots                     # foo/bar/.. is not foo/ even if bar is a symlink
unsetopt chase_links                    # cd to a symlink is in fact cd to the true dir
setopt   check_jobs                     # check jobs on exit
unsetopt clobber                        # prevents accidentally overwriting an existing file
unsetopt csh_junkiehistory              # single ! is last command
unsetopt csh_junkie_loops               # want do /list/; done
unsetopt csh_junkie_quotes              # no unescape newlines in quote
unsetopt csh_nullcmd                    # don't use $NULLCMD, $READNULLCMD
unsetopt csh_null_glob                  # ony one glob must match
unsetopt dvorak
unsetopt emacs                          # emacs builtin bindkyes
setopt   equals                         # perform =cmd/file expansions
unsetopt err_exit                       # exit shell on shell error
unsetopt err_return                     # return from a function with non 0 ending cmds
setopt   exec                           # execute commands
setopt   extended_glob                  # #,^,~ expansion
unsetopt flow_control                   # bind <ctrl s> and <ctrl q>
setopt   function_argzero               # $0 == name of script
setopt   glob                           # perform globbing
unsetopt global_export                  # typeset -x apply global variable
setopt   global_rcs                     # use /etc startup files
setopt   glob_assign                    # scalar=* globs on right
setopt   glob_dots                      # allow . files be matched without explicitly specifying the dot
unsetopt glob_subst                     # text on params can glob / recursive glob
setopt   hash_cmds                      # do not always search through path, hash cmds
setopt   hash_dirs                      # hash directories holding commands too
setopt   hash_list_all                  # verify path hash on completion
unsetopt hup                            # and don't kill them, either
unsetopt ignore_braces                  # no braces expansion
unsetopt ignore_eof                     # ignore ^D
unsetopt ksh_arrays                     # emulate ksh arrays
unsetopt ksh_autoload                   # do some dark autoload on function call
unsetopt ksh_glob                       # emulate ksh patterns, *(...) etc.
unsetopt ksh_option_print               # print options like ksh
unsetopt ksh_typeset                    # use ksh typeset
setopt   local_options                  # Options reset on function return
is-at-least 3.0.8 && setopt local_traps # Traps reset on function return.
setopt   long_list_jobs                 # list jobs in long format
unsetopt mail_warning                   # auto-explained
#setopt   monitor                        # job control
setopt   multios                        # multi redirection allowed
setopt   notify                         # notify immediately, not on next prompt / notify bg jobs on change
setopt   null_glob                      # failed globs are removed from line
setopt   numeric_glob_sort              # sort in numeric order rather than lexicographic
unsetopt octal_zeroes                   # 010 = 9
unsetopt print_exit_value               # Return status printed unless zero
setopt   pushd_ignore_dups              # only one instance of dir on stack
setopt   pushd_silent
setopt   short_loops                    # allow short loop forms: for file in *.pdf; lp ${file}
unsetopt shwordsplit                    # var="foo bar", echo $# for $var return 2 instead of 1, like sh and ksh


###################
#                 #
#     OPTIONS     #
#                 #
###################
# man zshoptions
setopt   aliases                                   # expand aliases
setopt   always_last_prompt                        # back to the prompt after list (note: if unset broke menu selection via cursor)
setopt   always_to_end                             # when complete from middle, move cursor
setopt   append_history                            # append to history, dont truncate it
setopt   auto_list                                 # list choice on ambiguous command
setopt   auto_menu                                 # show menu for completion after 2nd TAB
unsetopt autoname_dirs                             # after foo=/absolute/path, ~foo may expand to
                                                   #     /absolute/path, but '%~' in prompt won't give
                                                   #     '~foo' until '~foo' has been used (rtfm closely)
setopt   auto_param_keys                           # remove trailing spaces after completion if needed
setopt   auto_param_slash                          # add slash for directories
setopt   auto_remove_slash                         # remove slash on dirs if word separator added
setopt   auto_resume                               # single word resume if possible / cmd can behave like %cmd
setopt   bad_pattern                               # warn on bad file pattern
setopt   bang_hist                                 # ! expansion
unsetopt bash_auto_list                            # list only on 2nd TAB
setopt   complete_aliases                          # don.t expand aliases _before_ completion has finished
setopt   complete_in_word                          # not just at the end
setopt   correct                                   # spelling correction
unsetopt correct_all                               # correct args
unsetopt extended_history                          # save timestamps to history file
unsetopt glob_complete                             # cycle through globbing matches like menu_complete
setopt   hist_allow_clobber                        # add | to redirections in history
unsetopt hist_beep
is-at-least 3.0.8 && setopt hist_expire_dups_first # don't remove duplicated commands, even if they aren't sequential in history
is-at-least 3.0.8 && setopt hist_find_no_dups      # searching in history will skip duplicate entries when searching
is-at-least 3.0.8 && setopt hist_ignore_all_dups   # Remove all earlier duplicate lines
setopt   hist_ignore_dups                          # If the same command is run multiple times in a row, it is only entered in history once
setopt   hist_ignore_space                         # Dont store lines started with space
unsetopt hist_no_functions                         # don't save functions defs in history
unsetopt hist_no_store                             # remove hists access cmds from hist
setopt   hist_reduce_blanks                        # Trim multiple insignificant blank
is-at-least 3.0.8 && setopt hist_save_no_dups      # Remove duplicates when saveing
setopt   hist_verify                               # when using ! cmds, confirm first
is-at-least 3.0.8 && setopt inc_append_history     # each shell has a unique history while it's running, but stores an interleaved set of history in the file
unsetopt list_ambiguous                            # nothing is listed if there is an unambiguous prefix or suffix to be inserted
unsetopt list_beep                                 # beep on ambiguous completion
is-at-least 3.0.8 && setopt list_packed            # compact completion lists
unsetopt list_rows_first                           # list row first in completion
setopt   list_types                                # show types of listing files
setopt   magic_equal_subst                         # foo= is file expanded
setopt   mark_dirs                                 # adds / on dirs in filename completion
unsetopt   menu_complete                             # always inserted first match, TAB changes to the next
setopt   nomatch                                   # print error on non matched patterns
unsetopt overstrike                                # start le in overstrike mode
unsetopt prompt_cr                                 # don't add \r which overwrites cmd output with no \n (echo -n foo)
setopt   prompt_subst                              # turn on various expansions in prompts
setopt   rec_exact                                 # in completion, recognize exact matches even if they are ambiguous
is-at-least 3.0.8 && setopt share_history          # always import new commands from $HISTFILE
is-at-least 3.0.8 && unsetopt transient_rprompt    # right prompts automatically disappear when you press RETURN to execute the command

#limit core 0                   # no core dumps


