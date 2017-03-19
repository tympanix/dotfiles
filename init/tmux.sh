#!/usr/bin/env bash

########################################
# Installation fo tmux plugins         #
########################################

DIR="$(dirname "${BASH_SOURCE[0]}")"

# Must be called as part of dotfiles installation
[[ ! $DOTFILES ]] && exit 1

symlink_folder() {
  mv -f "$HOME/.tmux" "$BACKUP" 2> /dev/null
  ln -s "$DOTFILES/tmux" "$HOME/.tmux" > /dev/null \
    && success "Linked tmux folder" \
    || error "Could not link tmux folder"
}

install_tpm() {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1 \
    && success "Installed tmux plugin manager" \
    || error "Could not install tmux plugin manager"
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
install_plugins
reload_tmux
