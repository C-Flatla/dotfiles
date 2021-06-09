#!/bin/bash

link_all () {
  echo "Symlinking all dotfiles"
  for file in $( ls -A | grep -vE '\.sh|\.git$|\.gitignore$|.*.md|LICENSE|.mac_os' ) ; do
    # Silently ignore errors here because the files may already exist
    ln -svf "$PWD/$file" "$HOME"
  done
}

configure_mac() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Configuring for Mac"
    . .mac_os
  fi
}

link_all
configure_mac

echo "Done :)"
