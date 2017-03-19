#!/usr/bin/env bash

########################################
# Installation of vim files            #
########################################

DIR="$(dirname "${BASH_SOURCE[0]}")"

# Must be called as part of dotfiles installation
[[ ! $DOTFILES ]] && exit 1

install_pathogen() {
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim \
    && success "Installed pathogen" \
    || error "Could not install pathogen"
}

symlink_files() {
  mv -f "$HOME/.vim" "$BACKUP" 2> /dev/null
  ln -s "$DOTFILES/vim" "$HOME/.vim" \
    && success "Symlinked vim folder" \
    || error "Could not symlink vim folder"
}

symlink_files
install_pathogen
# install_plugins
