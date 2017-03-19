#!/usr/bin/env bash

########################################
# Installation of oh-my-zsh            #
########################################

DIR="$(dirname "${BASH_SOURCE[0]}")"

# Must be called as part of dotfiles installation
[[ ! $DOTFILES ]] && exit 1
[[ ! $LOG ]] && LOG="/dev/null"

ZSH=~/.oh-my-zsh

install_zsh () {
  # Test to see if zshell is installed.  If it is:
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Install Oh My Zsh if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
      git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$ZSH" > /dev/null 2>&1 \
      && success "Installed oh-my-zsh" \
      || error "Could not install oh-my-zsh"
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
      chsh -s $(which zsh)
    fi
  else
    error "Could not install oh-my-zsh missing zsh dependency"
  fi
}

symlink_files() {
  cp -as "$DOTFILES/zsh/"* "$HOME/.oh-my-zsh/" \
    && success "Symlinked zsh themes" \
    || error "Could not symlink oh-my-zsh files"
}

install_zsh
symlink_files
