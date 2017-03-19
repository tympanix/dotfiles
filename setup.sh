#!/bin/bash

# This symlinks all the dotfiles (and .atom/) to ~/
# It also symlinks ~/bin for easy updating

# This is safe to run multiple times and will prompt you about anything unclear

# Get the dotfiles directory's absolute path
DOTFILES="$(cd "$(dirname "$0")"; pwd -P)"
INSTALL="${DOTFILES}/install"
LOG="${DOTFILES}/logfile.log"

source "${INSTALL}/util.sh"

BACKUP=~/dotfiles_old             # old dotfiles backup directory

# Export variables for submodules
export DOTFILES
export LOG
export BACKUP

# Warn user this script will overwrite current dotfiles
while true; do
  question "Warning: this will overwrite your current dotfiles. Continue? [y/n] " && read yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Create dotfiles_old in homedir
mkdir -p $BACKUP

# Change to the dotfiles directory
cd $DOTFILES

#
# Actual symlink stuff
#


# Atom editor settings
info "Setting up atom"
mv -f ~/.atom ~/dotfiles_old/ 2> /dev/null
ln -s $HOME/dotfiles/atom ~/.atom \
  && success "Copied atom folder" \
  || error "Could not symlink atom directory"


declare -a FILES_TO_SYMLINK=(

  'shell/aliases'
  'shell/exports'
  'shell/functions'
  'shell/bash_profile'
  'shell/bash_prompt'
  'shell/bashrc'
  'shell/zshrc'
  'shell/curlrc'
  'shell/inputrc'
  'shell/screenrc'
  'shell/vimrc'
  'shell/wgetrc'
  'shell/tmux.conf'

  'git/gitattributes'
  'git/gitconfig'
  'git/gitignore'

)

# FILES_TO_SYMLINK="$FILES_TO_SYMLINK .vim bin" # add in vim and the binaries

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files

for i in ${FILES_TO_SYMLINK[@]}; do
  mv ~/.${i##*/} ~/dotfiles_old/ 2> /dev/null
done


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  local i=''
  local sourceFile=''
  local targetFile=''

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  info "Symlinking dotfiles"
  for i in ${FILES_TO_SYMLINK[@]}; do

    sourceFile="$(pwd)/$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ ! -e "$targetFile" ]; then
      execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
      success "$targetFile → $sourceFile"
    else
      ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
      if answer_is_yes; then
        rm -rf "$targetFile"
        execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
      else
        error "$targetFile → $sourceFile"
      fi
    fi

  done

  unset FILES_TO_SYMLINK

  # Copy binaries
  ln -fs $HOME/dotfiles/bin $HOME

  declare -a BINARIES=(
    # Binaries to copy
  )

  for i in ${BINARIES[@]}; do
    echo "Changing access permissions for binary script :: ${i##*/}"
    chmod +rwx $HOME/bin/${i##*/}
  done

  unset BINARIES

}

install_init_files() {
  for f in ${DOTFILES}/init/*.sh; do
    info "Installing using $(basename $f)"
    . "$f"
  done
}


install_dependecies() {
  if [ -f /usr/bin/apt-get ]; then
    source "$DOTFILES/install/apt.sh" 
  else
    error "You distribution is not supported"
    exit 1
  fi
}


# Package managers & packages

# . "$DOTFILES/install/brew.sh"
# . "$DOTFILES/install/npm.sh"

# if [ "$(uname)" == "Darwin" ]; then
    # . "$DOTFILES/install/brew-cask.sh"
# fi

install_dependecies
main
install_init_files

###############################################################################
# Atom                                                                        #
###############################################################################

# Copy over Atom configs
#cp -r atom/packages.list $HOME/.atom

# Install community packages
#apm list --installed --bare - get a list of installed packages
#apm install --packages-file $HOME/.atom/packages.list

###############################################################################
# Zsh                                                                         #
###############################################################################

# Install Zsh settings

# Reload zsh settings
# source ~/.zshrc
