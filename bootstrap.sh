link_all () {
  echo "Symlinking all dotfiles"
  touch .aliases.local
  touch .bash_profile.local
  touch .bashrc.local
  touch .exports.local
  touch .functions.local
  touch .gitconfig.local
  touch .zshrc.local
  for file in $( ls -A | grep -vE '\.sh|\.git$|\.vscode$|\.gitignore$|.*.md|LICENSE|.mac_os' ) ; do
    # Silently ignore errors here because the files may already exist
    ln -svf "$PWD/$file" "$HOME/"
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
verbose_resource=true && source ~/.zshrc

echo "Done :)"
