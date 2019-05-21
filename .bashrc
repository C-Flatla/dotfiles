#***********************************************************************#
#                             Useful aliases                            #
#***********************************************************************#
alias l='ls -ahlp'
alias ll='ls -ahlp'
alias cl='clear'
alias ~='cd ~'
alias .='cd ..'
alias ..='cd ..'
alias s='git status'
alias prune='~/dev/scripts/gitbranchprune.rb'
alias master='git checkout master;git pull;'
alias grep='grep --color=always'

alias rebash='source ~/.bash_profile'
alias brc='code ~/.bashrc'

# use up and down arrow keys to move up/down in control-r history search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

#***********************************************************************#
#                             Useful functions                          #
#***********************************************************************#

# Parses the $PATH environment variable and splits them by ':' onto new lines
# Found from: http://www.cyberciti.biz/faq/howto-print-path-variable/
function path() {
  old=$IFS
  IFS=:
  printf "%s\n" $PATH
  IFS=$old
}

# Sets the name of the tab
# Found from:
# http://thelucid.com/2012/01/04/naming-your-terminal-tabs-in-osx-lion/
function tab() {
  current_directory=${PWD##*/}
  printf "\e]1;${1:-$current_directory}\a"
}

# Sets the name of the window
# Found from:
# http://thelucid.com/2012/01/04/naming-your-terminal-tabs-in-osx-lion/
function winname() {
  printf "\e]2;$1\a"
}

# Prints out your current ip address
# Found from: http://apple.stackexchange.com/questions/20547/how-do-i-find-my-ip-address-from-the-command-line
function myip {
  # For Unix machines
  local_ip=`ifconfig | grep --color=never 'inet.*broadcast' | awk '{ printf "\t%s\n", $2}'`
  printf "Local:\n$local_ip"
  # printf "$local_ip" | pbcopy
  printf "\nExternal:\n\t"
  dig +short myip.opendns.com @resolver1.opendns.com
  # If no dig use: (sudo apt-get install dnsutils)
  # curl http://ipecho.net/plain
}

function test_internet() {
  local_ip=`ifconfig | grep --color=never 'inet.*broadcast' | awk '{ printf "\t%s\n", $2}'`
  ping -c3 $local_ip
  echo ""
  ping 1.1.1.1
}

# Generates a string of the current git branch (only if in git like in cd())
# Found from: https://stackoverflow.com/a/1418022
function current_branch() {
  if [ -d .git ]; then
    git rev-parse --abbrev-ref HEAD
  fi
}

function current_branch_str() {
  if [ -d .git ]; then
    echo "(`current_branch`)"
  else
    echo ""
  fi
}

# Run 'nvm use' automatically every time there's a .nvmrc file in the directory.
# Also, revert to default version when entering a directory without .nvmrc
# Found from: https://github.com/creationix/nvm#bash
find-up () {
    path=$(pwd)
    while [[ "$path" != "" && ! -e "$path/$1" ]]; do
        path=${path%/*}
    done
    echo "$path"
}

cdnvm(){
    cd "$@";
    nvm_path=$(find-up .nvmrc | tr -d '[:space:]')

    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then

        declare default_version;
        default_version=$(nvm version default);

        # If there is no default version, set it to `node`
        # This will use the latest version on your machine
        if [[ $default_version == "N/A" ]]; then
            nvm alias default node;
            default_version=$(nvm version default);
        fi

        # If the current version is not the default version, set it to use the default version
        if [[ $(nvm current) != "$default_version" ]]; then
            nvm use default;
        fi

        elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
        declare nvm_version
        nvm_version=$(<"$nvm_path"/.nvmrc)

        declare locally_resolved_nvm_version
        # `nvm ls` will check all locally-available versions
        # If there are multiple matching versions, take the latest one
        # Remove the `->` and `*` characters and spaces
        # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
        locally_resolved_nvm_version=$(nvm ls --no-colors $(<"./.nvmrc") | tail -1 | tr -d '\->*' | tr -d '[:space:]')

        # If it is not already installed, install it
        # `nvm install` will implicitly use the newly-installed version
        if [[ "$locally_resolved_nvm_version" == "N/A" ]]; then
            nvm install "$nvm_version";
        elif [[ $(nvm current) != "$locally_resolved_nvm_version" ]]; then
            nvm use "$nvm_version";
        fi
    fi
}
alias cd='cdnvm'

#***********************************************************************#
#                        Useful terminal settings                       #
#***********************************************************************#
# http://bashrcgenerator.com/
#                  [grey]  [time]      [teal]  [user]     [white]  [:]      [yellow][directory] [orange]      [git branch]       [white]    [$]
export PS1="\[\033[38;5;8m\][\@]\[\033[38;5;14m\]\u\[\033[38;5;15m\]:\[\033[38;5;220m\]\w\[\033[38;5;208m\]\$(current_branch_str)\[\033[38;5;15m\]\$ "
export LSCOLORS=ExFxBxDxCxegedabagacad
export CLICOLOR=1

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
