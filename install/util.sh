#!/bin/bash


#
# Utils
#

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}

ask() {
  question "$1"
  read
}

ask_for_confirmation() {
  question "$1 (y/n) "
  read -n 1
  printf "\n"
}

ask_for_sudo() {

  # Ask for the administrator password upfront
  sudo -v

  # Update existing `sudo` time stamp until this script has finished
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &

}

cmd_exists() {
  [ -x "$(command -v "$1")" ] \
    && printf 0 \
    || printf 1
}

execute() {
  $1 &> /dev/null
  result $? "${2:-$1}"
}

get_answer() {
  printf "$REPLY"
}

get_os() {

  declare -r OS_NAME="$(uname -s)"
  local os=""

  if [ "$OS_NAME" == "Darwin" ]; then
    os="osx"
  elif [ "$OS_NAME" == "Linux" ] && [ -e "/etc/lsb-release" ]; then
    os="ubuntu"
  fi

  printf "%s" "$os"

}

is_git_repository() {
  [ "$(git rev-parse &>/dev/null; printf $?)" -eq 0 ] \
    && return 0 \
    || return 1
}

mkd() {
  if [ -n "$1" ]; then
    if [ -e "$1" ]; then
      if [ ! -d "$1" ]; then
        error "$1 - a file with the same name already exists!"
      else
        success "$1"
      fi
    else
      execute "mkdir -p $1" "$1"
    fi
  fi
}

error() {
  # Print output in red
  printf "\e[0;31m      [✖] $1 $2\e[0m\n"
  exit 1
}

info() {
  # Print output in purple
  printf "\e[0;35m    $1\e[0m\n"
}

question() {
  # Print output in yellow
  printf "\e[0;33m  [?] $1\e[0m"
}

result() {
  [ $1 -eq 0 ] \
    && success "$2" \
    || error "$2"

  [ "$3" == "true" ] && [ $1 -ne 0 ] \
    && exit
}

success() {
  # Print output in green
  printf "\e[0;32m      [✔] $1\e[0m\n"
}


