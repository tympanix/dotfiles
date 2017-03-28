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

install_vundle() {
  VUNDLE="$HOME/.vim/bundle/Vundle.vim"
  if [ -d $VUNDLE ]; then
    success "Vundle already installed"
  else 
    git clone https://github.com/VundleVim/Vundle.vim.git \
    $HOME/.vim/bundle/Vundle.vim >> $LOG 2>&1 \
      && success "Installed vundle" \
      || error "Could not install vundle"
  fi
}

symlink_files() {
	if [[ -d "$HOME/.vim" ]]; then
	  if [[ -L "$HOME/.vim" ]]; then
      rm -f "$HOME/.vim" 2> /dev/null
		else
      mv -f "$HOME/.vim" "$BACKUP" 2> /dev/null
		fi
	fi
  ln -s "$DOTFILES/vim" "$HOME/.vim" \
    && success "Symlinked vim folder" \
    || error "Could not symlink vim folder"
}

install_plugins() {
  vim --noplugin -u $HOME/.vim/vundles.vim -N \"+set hidden\" \"+syntax on\" \
    +PluginClean +PluginInstall! +qall > $LOG 2>&1 \
    && success "Install all vim plugins" \
    || error "Could not install vim plugins"
}

symlink_files
install_vundle
install_plugins
