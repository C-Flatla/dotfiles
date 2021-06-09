#!/bin/bash

# **********************************************************************#
#                        Source related files                           #
#***********************************************************************#
[ -f $HOME/.exports ] && source $HOME/.exports
[ -f $HOME/.functions ] && source $HOME/.functions
[ -f $HOME/.aliases ] && source $HOME/.aliases

[ -f $HOME/.bashrc ] && source $HOME/.bashrc

if [[ $verbose_rebash ]]; then echo "SOURCED .bash_profile"; fi

# This should be the last line of the file
# For local changes
# Don't make edits below this
[ -f "$HOME/.bash_profile.local" ] && source "$HOME/.bash_profile.local"
