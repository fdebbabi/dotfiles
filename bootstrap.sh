#!/usr/bin/env bash
# Bootstrap on a fresh Mac. Download this script standalone and run it —
# it will clone the dotfiles repo, install packages, and link everything.
# Prerequisites: Homebrew + git (Xcode CLI tools).
# Safe to re-run.

set -euo pipefail


################### INITIALIZATION

GIT_URL=https://github.com/fdebbabi/dotfiles.git
WORKSPACE=$HOME/Workspace
DOTFILES=$WORKSPACE/dotfiles

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


################### PACKAGES

FORMULAE=(
  stow eza bat chafa cmus htop jq neovim ranger tmux tree yq pgcli gh fzf
)
CASKS=(
  karabiner-elements
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


################### STOW DOTFILES

PACKAGES=(zsh git tmux karabiner vim claude pgcli flameshot)

echo "==> Stowing: ${PACKAGES[*]}"
stow --restow -t "$HOME" "${PACKAGES[@]}"


################### DEFAULT SHELL

if [[ "$SHELL" != *zsh* ]]; then
  echo "==> Setting default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi

echo "==> Done."