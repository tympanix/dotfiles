#!/usr/bin/env bash

########################################
# Installation of vim files            #
########################################

DIR="$(dirname "${BASH_SOURCE[0]}")"

# Must be called as part of dotfiles installation
[[ ! $DOTFILES ]] && exit 1

install_vundle() {
  git clone "https://github.com/VundleVim/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim" > /dev/null \
    && success "Installed vundle for vim" \
    || error "Could not install vundle for vim"
}

symlink_files() {
  mkd "$HOME/.vim" 
  cp -as "$DOTFILES/vim/"* "$HOME/.vim/" \
    && success "Symlinked vim themes" \
    || error "Could not symlink vim files"
}

install_plugins() {
  vim +PluginInstall +qall \
    && success "Installed vim plugins" \
    || error "Could not install vim plugins"
}
install_vundle
symlink_files
install_plugins
