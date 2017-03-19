#!/usr/bin/env bash

########################################
# Installation for apt package manager #
########################################

DIR="$(dirname "${BASH_SOURCE[0]}")"
source "${DIR}/util.sh"

[[ ! $LOG ]] && LOG="/dev/null"

PACKAGES=(
  'vim'
  'tmux'
  'zsh'
  'curl'
  'git-core'
)

info "Installing dependencies with apt-get"
sudo apt-get -qq update \
  && success "Updated apt-get" \
  || error "Could not update apt-get"


for i in ${PACKAGES[@]}; do
  sudo apt-get install -y "$i" >> "$LOG" 2>&1 \
    && success "Installed $i" \
    || error "Could not install $i"
done

unset PACKAGES
