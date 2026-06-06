#!/usr/bin/env bash
# Bootstrap on a fresh Mac. Download this script standalone and run it —
# it will clone the dotfiles repo, install packages, and link everything.
# Prerequisites: Homebrew + git (Xcode CLI tools).
# Safe to re-run.

set -euo pipefail


################### INITIALIZATION

GIT_URL=https://github.com/fdebbabi/dotfiles.git
WORKSPACE=$HOME/Workspace
DOTFILES=$WORKSPACE/Git-Repos/dotfiles

mkdir -p "$WORKSPACE"/{Git-Repos,Youtube,Other}
mkdir -p "$HOME"/.config "$HOME"/.claude


################### CLONE OR UPDATE DOTFILES

if [ ! -d "$DOTFILES" ]; then
  echo "==> Cloning dotfiles..."
  git clone "$GIT_URL" "$DOTFILES"
else
  echo "==> Updating dotfiles..."
  git -C "$DOTFILES" pull --ff-only
fi
cd "$DOTFILES"

################### HOMEBREW macos package manager

if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Homebrew to PATH (M1/M2/M3/M4 Macs)
  eval "$(/opt/homebrew/bin/brew shellenv)" # Necessary for subsequent calls to be aware of brew
fi

################### UPDATE OUTDATED PACKAGES

echo "==> Updating outdated formulae..."
brew upgrade

################### INSTALL STOW FIRST

echo "==> Installing stow..."
brew install stow


################### STOW DOTFILES

# Clean up any auto-generated dotfiles that conflict
rm -f "$HOME/.zprofile" "$HOME/.zshrc"

PACKAGES=(zsh git tmux karabiner vim claude pgcli flameshot)

echo "==> Stowing: ${PACKAGES[*]}"
stow --restow -t "$HOME" "${PACKAGES[@]}"


################### PACKAGES

FORMULAE=(
  stow eza bat chafa cmus htop jq neovim ranger tmux tree yq pgcli gh fzf node
)
CASKS=(
  scroll-reverser
  karabiner-elements
  rectangle
  maccy
  kitty
  google-chrome
  visual-studio-code
  orbstack
  postman
  drawio
  bitwarden
  veracrypt
  lunar
  screenflick
  microsoft-powerpoint
)

echo "==> Installing brew formulae..."
brew install "${FORMULAE[@]}"

echo "==> Installing brew casks..."
brew install --cask "${CASKS[@]}"


################### OH-MY-ZSH

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing oh-my-zsh..."
  KEEP_ZSHRC=yes RUNZSH=no CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


################### DEFAULT SHELL

if [[ "$SHELL" != *zsh* ]]; then
  echo "==> Setting default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi


echo "==> Done."

# Switch to zsh in current terminal
exec zsh -l

################### CLAUDE CODE CLI

if ! command -v claude >/dev/null 2>&1; then
  echo "==> Installing Claude Code CLI..."
  curl -fsSL https://claude.ai/install.sh | bash
fi


################### OPENCODE CLI

if ! command -v opencode >/dev/null 2>&1; then
  echo "==> Installing opencode CLI..."
  curl -fsSL https://opencode.ai/install | bash
fi


echo "==> Done."
