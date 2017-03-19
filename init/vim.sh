#!/usr/bin/env bash

########################################
# Installation of vim files            #
########################################

DIR="$(dirname "${BASH_SOURCE[0]}")"

# Must be called as part of dotfiles installation
[[ ! $DOTFILES ]] && exit 1

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
  git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
  git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
}
install_pathogen
symlink_files
install_plugins
