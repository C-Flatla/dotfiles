# **********************************************************************#
#                        Source related files                           #
#***********************************************************************#
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[ -f $HOME/.exports ] && source $HOME/.exports
[ -f $HOME/.functions ] && source $HOME/.functions
[ -f $HOME/.aliases ] && source $HOME/.aliases

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [[ $verbose_resource ]]; then echo "SOURCED .zshrc"; fi

# This should be the last line of the file
# For local changes
# Don't make edits below this
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
