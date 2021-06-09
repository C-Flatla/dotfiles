#!/bin/bash

# **********************************************************************#
#                        Source related files                           #
#***********************************************************************#
[ -f $HOME/.exports ] && source $HOME/.exports
[ -f $HOME/.functions ] && source $HOME/.functions
[ -f $HOME/.aliases ] && source $HOME/.aliases

[ -f $HOME/.bashrc ] && source $HOME/.bashrc


# This should be the last line of the file
# For local changes
# Don't make edits below this
[ -f ".bash_profile.local" ] && source ".bash_profile.local"
