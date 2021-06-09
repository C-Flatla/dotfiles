#!/bin/bash

# **********************************************************************#
#                        Source related files                           #
#***********************************************************************#

[ -f $HOME/.bashrc ] && source $HOME/.bashrc

# Clean up duplicates
# Found from: http://unix.stackexchange.com/a/40755
PATH=`printf %s "$PATH" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`

# This should be the last line of the file
# For local changes
# Don't make edits below this
[ -f ".bash_profile.local" ] && source ".bash_profile.local"
