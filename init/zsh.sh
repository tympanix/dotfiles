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
    if [[ ! -d "$ZSH" ]]; then
      git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$ZSH" > /dev/null 2>&1 \
      && success "Installed oh-my-zsh" \
      || error "Could not install oh-my-zsh"
		else
			success "Already installed oh-my-zsh"
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == "/bin/zsh" ]]; then
      chsh -s "/bin/zsh" \
			  && success "Changed default shell to zsh" \
				|| error "Could not change shell to zsh"
		else
		  success "Default shell already zsh"
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

source_zsh() {
  source "$HOME/.zshrc" \
	  && success "Sourced zshrc file" \
		|| error "Could not source zshrc file"
}

install_zsh
source_zsh
# symlink_files (option -s for cp not available for macos)
