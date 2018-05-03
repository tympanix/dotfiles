#!/usr/bin/env bash

########################################
# Installation fo tmux plugins         #
########################################

DIR="$(dirname "${BASH_SOURCE[0]}")"

# Must be called as part of dotfiles installation
[[ ! $DOTFILES ]] && exit 1

symlink_folder() {
  if [[ -L "$HOME/.tmux" && -d "$HOME/.tmux" ]]; then
    success "Tmux already linked"
  else
    mv -rf "$HOME/.tmux" "$BACKUP" 2> /dev/null
    ln -s "$DOTFILES/tmux" "$HOME/.tmux" > /dev/null \
      && success "Linked tmux folder" \
      || error "Could not link tmux folder"
  fi
}

install_tpm() {
  TPM="$HOME/.tmux/plugins/tpm"
  if [ -d $TPM ]; then
    success "Already installed tmux plugin manager"
  else
    git clone https://github.com/tmux-plugins/tpm $TPM >> $LOG 2>&1 \
      && success "Installed tmux plugin manager" \
      || error "Could not install tmux plugin manager"
  fi
}

reload_tmux() {
  tmux source-file ~/.tmux.conf > /dev/null 2>&1
  success "Reloaded tmux config"
}

install_plugins() {
  "$HOME/.tmux/plugins/tpm/bin/install_plugins" > /dev/null \
    && success "Installed tmux plugins" \
    || error "Could not install tmux plugins"
}

symlink_folder
install_tpm
reload_tmux
install_plugins
