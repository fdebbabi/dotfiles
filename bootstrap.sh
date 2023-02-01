#!/usr/bin/env bash

# This script allows you to bootsrap a Linux machine that has nix installed with flakes experimental features enabled for now

# Packages Installation section


# This is temporarly, need to refactor it with a simple array of these packages
nix profile install nixpkgs#bat
nix profile install nixpkgs#chafa
nix profile install nixpkgs#cmus
nix profile install nixpkgs#exa
nix profile install nixpkgs#git
nix profile install nixpkgs#htop
nix profile install nixpkgs#jq
nix profile install nixpkgs#neovim
nix profile install nixpkgs#python
nix profile install nixpkgs#tmux
nix profile install nixpkgs#tree
nix profile install nixpkgs#xclip
nix profile install nixpkgs#yq

# Configuration section
# 1. Need to clone my public repo
# 2. Create a symoblic link creation function
# 3. Create symlinks for the different configuration files in the good folders (Try to respect XDG Base Directory specification when possible)
# 4. Not sure for now, but need to setup also vim plugins(like Cellular-automaton) and stuff (probably should feasable using the CLI)
