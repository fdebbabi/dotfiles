#!/usr/bin/env bash

# This script allows you to bootsrap a Linux machine that has nix installed with flakes experimental features enabled for now

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


install sl bat chafa cmus exa git htop jq neovim python tmux tree xclip yq



############### Configuration section
# 1. Need to clone my public repo
# 2. Create a symoblic link creation function
# 3. Create symlinks for the different configuration files in the good folders (Try to respect XDG Base Directory specification when possible)
# 4. Not sure for now, but need to setup also vim plugins(like Cellular-automaton) and stuff (probably should feasable using the CLI)
