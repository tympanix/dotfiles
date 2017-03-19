#!/usr/bin/env bash

########################################
# Installation of vim files            #
########################################

DIR="$(dirname "${BASH_SOURCE[0]}")"

# Must be called as part of dotfiles installation
[[ ! $DOTFILES ]] && exit 1

PLUGINS=(
  'https://github.com/vim-airline/vim-airline-themes'
  'https://github.com/vim-airline/vim-airline'
)

install_pathogen() {
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
}

symlink_files() {
  mkd "$HOME/.vim" 
  cp -as "$DOTFILES/vim/"* "$HOME/.vim/" \
    && success "Symlinked vim themes" \
    || error "Could not symlink vim files"
}

install_plugins() {
  for p in ${PLUGINS[@]}; do
    git clone "$p" "$HOME/.vim/bundle/$(basename $p)" > /dev/null 2>&1 \
      && success "Installed vim plugin $(basename $p)" \
      || error "Could not install $(basename $p)"
  done  
}

install_pathogen
symlink_files
install_plugins
