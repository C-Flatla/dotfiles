#!/usr/bin/env bash

# use up and down arrow keys to move up/down in control-r history search
set -o vi # fixes 'line editing not enabled' when running ./bootstrap.sh
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

if [[ $verbose_resource ]]; then echo "SOURCED .bashrc"; fi

# This should be the last line of the file
# For local changes
# Don't make edits below this
[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"
