#!/usr/bin/env bash

################### INITIALIZATION SECTION
GIT_URL=git@github.com:fdebbabi/dotfiles.git
WORKSPACE=$HOME/Workspace
DOTFILES=$WORKSPACE/Git-Repos/dotfiles
DOTS=$DOTFILES/dots
mkdir -p $WORKSPACE/{Git-Repos,Youtube,Other}
mkdir -p $HOME/.config/{nvim,tmux,git,}

################### PACKAGES INSTALLATION SECTION
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

install sl bat chafa cmus exa git htop jq neovim python tmux tree xclip yq zsh oh-my-zsh
sudo -u root bash -c "echo $(which zsh) >> /etc/shells"


###################  CONFIGURATION SECTION 
if [ ! -d "$DOTFILES" ] ; then
    git clone $GIT_URL $FOLDER
else
    cd "$FOLDER"
    git pull $GIT_URL
fi

ln -f -s $DOTS/init.vim ~/.config/nvim/init.vim
ln -f -s $DOTS/tmux.conf ~/.config/tmux/tmux.conf
ln -f -s $DOTS/zshrc ~/.zshrc
ln -f -s $(nix profile list |grep "oh-my-zsh"  | awk '{print $4 "/share/oh-my-zsh"}') ~/.oh-my-zsh

chsh -s $(which zsh)

# 3. Not sure for now, but need to setup also vim plugins(like Cellular-automaton) and stuff (probably should feasable using the CLI)