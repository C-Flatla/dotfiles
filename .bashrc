#!/bin/bash

# use up and down arrow keys to move up/down in control-r history search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'


# This should be the last line of the file
# For local changes
# Don't make edits below this
[ -f ".bashrc.local" ] && source ".bashrc.local"
