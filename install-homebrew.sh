#!/bin/bash

# install-homebrew.sh
# Installs Homebrew package manager for macOS

set -e  # Exit on any error

echo "🍺 Installing Homebrew..."

# Check if Homebrew is already installed
if command -v brew >/dev/null 2>&1; then
    echo "✅ Homebrew is already installed"
    brew --version
    exit 0
fi

# Install Homebrew
echo "📥 Downloading and installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH for Apple Silicon Macs
if [[ $(uname -m) == 'arm64' ]]; then
    echo "🔧 Adding Homebrew to PATH for Apple Silicon..."
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Verify installation
if command -v brew >/dev/null 2>&1; then
    echo "✅ Homebrew installed successfully!"
    brew --version
else
    echo "❌ Homebrew installation failed"
    exit 1
fi

echo "🎉 Homebrew installation complete!"