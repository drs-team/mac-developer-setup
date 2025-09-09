#!/bin/bash

# configure-shell.sh
# Configures shell environment with oh-my-zsh and development tools

set -e  # Exit on any error

echo "🐚 Configuring Shell Environment..."

echo "⚡ Installing oh-my-zsh..."

# Install oh-my-zsh if not already installed
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "✅ oh-my-zsh already installed"
else
    echo "📥 Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "🔧 Configuring .zshrc..."

# Backup existing .zshrc
if [[ -f "$HOME/.zshrc" ]]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
    echo "📋 Backed up existing .zshrc to .zshrc.backup"
fi

# Create enhanced .zshrc configuration
cat > "$HOME/.zshrc" << 'EOF'
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Plugins to load
plugins=(
    git
    node
    npm
    docker
    aws
    brew
    macos
    vscode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Homebrew Configuration (Apple Silicon)
if [[ $(uname -m) == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Development Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias cat='bat'
alias ping='ping -c 5'
alias mkdir='mkdir -pv'
alias grep='rg'

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gb='git branch'
alias gco='git checkout'

# Development Aliases
alias ni='npm install'
alias ns='npm start'
alias nt='npm test'
alias nb='npm run build'
alias nrs='npm run start'
alias nrd='npm run dev'

# Docker Aliases
alias dk='docker'
alias dkc='docker-compose'
alias dki='docker images'
alias dkps='docker ps'

# AWS Aliases
alias awsp='export AWS_PROFILE='
alias awsl='aws s3 ls'

# Productivity Aliases
alias reload='source ~/.zshrc'
alias zshconfig='code ~/.zshrc'
alias ohmyzsh='code ~/.oh-my-zsh'

# Custom Functions
# Create and enter directory
mkcd() { mkdir -p "$1" && cd "$1"; }

# Find and kill process by name
killport() { lsof -ti:$1 | xargs kill -9; }

# Quick git commit with message
gac() { git add . && git commit -m "$1"; }

# Extract various archive formats
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Show current IP
myip() { curl -s https://ipinfo.io/ip; echo; }

# Weather function
weather() { curl -s "wttr.in/$1"; }

# Auto-load nvm when entering directory with .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Export PATH for additional tools
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Configure history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Enable case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

EOF

echo "✅ .zshrc configuration updated"

echo "🎨 Installing additional oh-my-zsh themes..."

# Install Powerlevel10k theme (optional)
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    echo "📥 Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "💡 To use Powerlevel10k, change ZSH_THEME to 'powerlevel10k/powerlevel10k' in ~/.zshrc"
fi

echo "🔧 Installing useful zsh plugins..."

# Install zsh-syntax-highlighting
if [[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
    echo "📥 Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install zsh-autosuggestions
if [[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
    echo "📥 Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

echo "🎉 Shell configuration complete!"

echo "📋 What was configured:"
echo "✅ oh-my-zsh with useful plugins (git, node, docker, aws, etc.)"
echo "✅ Development aliases and functions"
echo "✅ NVM integration with auto-loading"
echo "✅ Enhanced history settings"
echo "✅ Custom productivity functions"
echo "✅ Additional themes and plugins available"

echo "🔄 Please restart your terminal or run: source ~/.zshrc"
echo "💡 Tip: Type 'alias' to see all available shortcuts"