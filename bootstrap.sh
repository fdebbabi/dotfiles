#!/usr/bin/env bash

# This script allows you to bootsrap a Linux machine that has nix installed with flakes experimental features enabled for now

############### Initilization

WORKSPACE=$HOME/Workspace
DOTFILES=$WORKSPACE/Git-Repos/dotfiles
DOTS=$DOTFILES/dots


mkdir -p $WORKSPACE/{Git-Repos,Youtube,Other}
mkdir -p $HOME/.config/{nvim,}

############### Packages Installation section


# There are some issues with profiles, need to make sure how this stuff is more user friendly
install() {
  echo "Installing the packages..."
  for package in "$@"
  do
	  echo "Installting $package"
	  nix profile install nixpkgs#$package
	  echo "Done installing $package"
  done
  echo "Done Installing packages."
 
}


# install sl bat chafa cmus exa git htop jq neovim python tmux tree xclip yq
# Here I use apt package manager as it changes the valid shells in /etc/shells automatically
# sudo apt install zsh
# Install oh-my-zsh


############### Configuration section
# 1. Need to clone my public repo
# This script needs to be idempotent (pour ne pas se faire chier s'il y a des choses qui existent ou autre.. x))
git clone git@github.com:fdebbabi/dotfiles.git $DOTFILES

# 2. Create a symoblic link creation function

# This function is for now a 100% copy and paste from https://github.com/bew/dotfiles
function make-link
{
  local link_to="$1"
  local link_destination="$2"

  # When linking `src/bar` to `foo/`
  # $link_destination should be `foo/bar`
  #
  # NOTE: in bash, ${foo:(-N)} takes last N chars
  # Ref: https://stackoverflow.com/a/19858692
  if [[ "${link_destination:(-1)}" == "/" ]]; then
    link_destination="${link_destination}$(basename "$link_to")"
  fi

  local old_link_to="$(readlink "$link_destination" || true)"
  if [[ "$link_to" == "$old_link_to" ]]; then
    echo "nothing to do, '$link_destination' already points to '$link_to'"
    return
  fi

  if [[ "$DRYRUN_ONLY" == "true" ]]; then
    local before before_short
    if [[ -n "$old_link_to" ]]; then
      before_short=R
      before="was '$old_link_to'"
    else
      before_short=N
      before="to create"
    fi
    echo "DRYRUN[$before_short]: '$link_destination' -> '$link_to' ($before)"
  else
    ln -vsf --no-dereference "$link_to" "$link_destination"
  fi
}

# 3. Create symlinks for the different configuration files in the good folders (Try to respect XDG Base Directory specification when possible)
# Testing with a single conf for now (neovim)
make-link $DOTS/init.vim ~/.config/nvim/init.vim
ln -s $DOTS/zshrc ~/.zshrc

# 4. Not sure for now, but need to setup also vim plugins(like Cellular-automaton) and stuff (probably should feasable using the CLI)
