if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# This should be the last line of the file
# For local changes
# Don't make edits below this
[ -f "$HOME/.zprofile.local" ] && source "$HOME/.zprofile.local"
