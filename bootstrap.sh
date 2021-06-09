#!/bin/bash

link_all () {
  for file in $( ls -A | grep -vE '\.sh|\.git$|\.gitignore|.*.md|LICENSE' ) ; do
    # Silently ignore errors here because the files may already exist
    ln -sv "$PWD/$file" "$HOME" || true
  done
}

link_all
