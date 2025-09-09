#!/bin/bash

# setup-development.sh
# Sets up Node.js development environment with nvm and package managers

set -e  # Exit on any error

echo "🚀 Setting up Development Environment..."

# Check if Homebrew is available
if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew not found. Please run install-homebrew.sh first"
    exit 1
fi

echo "📦 Installing NVM (Node Version Manager)..."

# Install NVM
if [[ -d "$HOME/.nvm" ]]; then
    echo "✅ NVM already installed"
else
    echo "📥 Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    
    # Load NVM immediately
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Load NVM for this session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "🟢 Installing Node.js LTS..."
if command -v node >/dev/null 2>&1; then
    echo "✅ Node.js already installed: $(node --version)"
else
    nvm install --lts
    nvm use --lts
    nvm alias default lts/*
fi

echo "📦 Installing Package Managers..."

# Install yarn and pnpm globally
if command -v yarn >/dev/null 2>&1; then
    echo "✅ Yarn already installed: $(yarn --version)"
else
    echo "📥 Installing Yarn..."
    npm install -g yarn
fi

if command -v pnpm >/dev/null 2>&1; then
    echo "✅ pnpm already installed: $(pnpm --version)"
else
    echo "📥 Installing pnpm..."
    npm install -g pnpm
fi

# Install useful global packages
echo "🔧 Installing useful global npm packages..."

GLOBAL_PACKAGES=(
    "pm2"                   # Process manager for Node.js
    "nodemon"              # Auto-restart during development
    "@aws-cdk/cli"         # AWS CDK command line interface
    "serverless"           # Serverless framework
    "typescript"           # TypeScript compiler
    "ts-node"              # TypeScript execution engine
    "eslint"               # JavaScript/TypeScript linter
    "prettier"             # Code formatter
)

for package in "${GLOBAL_PACKAGES[@]}"; do
    if npm list -g "$package" >/dev/null 2>&1; then
        echo "✅ $package already installed globally"
    else
        echo "📥 Installing $package globally..."
        npm install -g "$package"
    fi
done

echo "🎉 Development Environment setup complete!"

# Display versions
echo "📋 Installed versions:"
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "yarn: $(yarn --version)"
echo "pnpm: $(pnpm --version)"
echo "TypeScript: $(tsc --version)"

echo "🔧 NVM Commands:"
echo "  nvm ls                 - List installed Node versions"
echo "  nvm install 18         - Install Node.js v18"
echo "  nvm use 18             - Switch to Node.js v18"
echo "  nvm alias default 18   - Set v18 as default"