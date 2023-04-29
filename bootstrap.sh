#!/usr/bin/env bash

# This script requires nix package manager installed with flakes enabled and zsh shell available

################### INITIALIZATION SECTION
GIT_URL=https://github.com/fdebbabi/dotfiles.git
WORKSPACE=$HOME/Workspace
DOTFILES=$WORKSPACE/Git-Repos/dotfiles
DOTS=$DOTFILES/dots
mkdir -p $WORKSPACE/{Git-Repos,Youtube,Other}
mkdir -p $HOME/{.config/{nvim,tmux,git,oh-my-posh,},.fonts,}

################### PACKAGES INSTALLATION SECTION
# There are some issues with profiles, need to make sure how this stuff is more user friendly
install() {
  echo "Installing the packages..."
  for package in "$@"
  do
	  echo "Installting $package"
	  nix profile install nixpkgs#$package --extra-experimental-features nix-command --extra-experimental-features flakes
	  echo "Done installing $package"
  done
  echo "Done Installing packages."
}

# install sl bat chafa cmus exa htop jq neovim python3 ranger tmux tree xclip yq oh-my-zsh asciiquarium
install_oh_my_posh() {
	echo "Installing OhMyPosh..."
	sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
	sudo chmod +x /usr/local/bin/oh-my-posh
	echo "Done Installing OhMyPosh"
}

# install_oh_my_posh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"  --keep-zshrc

###################  CONFIGURATION SECTION 
if [ ! -d "$DOTFILES" ] ; then
    echo "Entered dotfiles creation.."
    git clone $GIT_URL $DOTFILES
else
    cd "$DOTFILES"
    git pull $GIT_URL
fi

ln -f -s -n $DOTS/init.vim ~/.config/nvim/init.vim
ln -f -s -n $DOTS/tmux.conf ~/.config/tmux/tmux.conf
ln -f -s -n $DOTS/"Meslo LG L DZ Bold Nerd Font Complete.ttf" ~/.fonts/"Meslo LG L DZ Bold Nerd Font Complete.ttf"
ln -f -s -n $DOTS/fayez-theme.omp.json ~/.config/oh-my-posh/fayez-theme.omp.json
ln -f -s -n $DOTS/zshrc ~/.zshrc
ln -f -s -n $DOTS/hyper.js ~/.hyper.js

echo "Building font information caches..."
# fc-cache -f 

echo "Updating login shell to ZSH..."
# chsh -s $(which zsh)

# 3. Not sure for now, but need to setup also vim plugins(like Cellular-automaton) and stuff (probably should feasable using the CLI)
# Need to install Plug plugin manager, cellular-automaton and treesitter plugins with Python parser
