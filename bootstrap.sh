#!/bin/zsh

link_all () {
  echo "Symlinking all dotfiles"
  touch .aliases.local
  touch .bash_profile.local
  touch .bashrc.local
  touch .exports.local
  touch .functions.local
  touch .gitconfig.local
  touch .zprofile.local
  touch .zshrc.local
  for file in $( ls -A | grep -vE '\.sh|\.git$|\.vscode$|\.gitignore$|.*.md|LICENSE|.mac_os' ) ; do
    # Silently ignore errors here because the files may already exist
    ln -sv "$PWD/$file" "$HOME/"
  done
}

configure_mac() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Configuring for Mac"
    . .mac_os
  fi
}

configure_prezto() {
  echo "Configuring Prezto"

  if [[ ! -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    echo "Cloning Prezto"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  fi

  # setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -sv "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
}

link_all
. brew.sh
configure_mac
configure_prezto
verbose_resource=true && source ~/.zshrc

echo "Done :)"
