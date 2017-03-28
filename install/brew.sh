#!/usr/bin/env bash

#########################################
# Installation for brew package manager #
#########################################

DIR="$(dirname "${BASH_SOURCE[0]}")"
source "${DIR}/util.sh"

[[ ! $LOG ]] && LOG="/dev/null"

PACKAGES=(
  'vim'
  'tmux'
  'zsh'
  'curl'
  'git'
	'coreutils'
	'wget'
)

info "Installing dependeciens with brew"

# Make sure we’re using the latest Homebrew.
brew update > /dev/null \
  && success "Updated brew packages" \
	|| error "Could not update brew packages"

for i in ${PACKAGES[@]}; do
  brew install "$i" >> $LOG 2>&1 \
	  && success "Installed $i" \
		|| error "Could not install $i"

# Remove outdated versions from the cellar.
brew cleanup

unset PACKAGES
