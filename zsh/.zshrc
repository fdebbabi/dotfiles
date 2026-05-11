export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"


zstyle ':omz:update' mode disabled  # disable automatic updates

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.local/bin:$PATH"

# Custom configuration
alias l='eza -l --header --no-time --group-directories-first'
alias ll='eza -la --header --no-time --group-directories-first'
alias lll='eza -la --header --group-directories-first'
alias cat='bat'


export PATH="/Users/fdebbabi/Workspace/InfraPlayground/binaries:$PATH"
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

