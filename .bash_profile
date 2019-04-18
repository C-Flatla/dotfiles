# ***********************************************************************#
#                        Source related files                           #
#***********************************************************************#
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"

# Bash completion
source /usr/local/etc/bash_completion.d/git-completion.bash
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# .bashrc
[[ -s ~/.bashrc ]] && source ~/.bashrc

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#***********************************************************************#
#                        Path related settings                          #
#***********************************************************************#


#***********************************************************************#
#                        ENV variables                                  #
#***********************************************************************#


# Clean up duplicates
# Found from: http://unix.stackexchange.com/a/40755
PATH=`printf %s "$PATH" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
