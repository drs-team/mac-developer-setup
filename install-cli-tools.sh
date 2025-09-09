#!/bin/bash

# install-cli-tools.sh
# Installs essential command line tools for backend development

set -e  # Exit on any error

echo "⚡ Installing CLI Tools..."

# Check if Homebrew is available
if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew not found. Please run install-homebrew.sh first"
    exit 1
fi

echo "📦 Installing command line tools..."

# Core development tools
CLI_TOOLS=(
    "git"           # Version control
    "docker"        # Containerization CLI
    "awscli"        # AWS command line interface
    "bat"           # Modern cat replacement with syntax highlighting
    "tree"          # Directory structure visualization
    "httpie"        # User-friendly HTTP client
    "jq"            # JSON processor
    "fzf"           # Fuzzy finder
    "ripgrep"       # Fast text search (rg command)
)

# Install CLI tools
for tool in "${CLI_TOOLS[@]}"; do
    if brew list "$tool" >/dev/null 2>&1; then
        echo "✅ $tool already installed - skipping"
    else
        echo "📥 Installing $tool..."
        brew install "$tool"
    fi
done

# Install Python (specific version for development)
if brew list python@3.12 >/dev/null 2>&1; then
    echo "✅ Python 3.12 already installed"
else
    echo "🐍 Installing Python 3.12..."
    brew install python@3.12
fi

echo "🔧 Installing Xcode Command Line Tools..."
if xcode-select -p >/dev/null 2>&1; then
    echo "✅ Xcode Command Line Tools already installed"
else
    xcode-select --install
    echo "⏳ Please complete the Xcode Command Line Tools installation when prompted"
fi

echo "🎉 CLI Tools installation complete!"

# Display versions
echo "📋 Installed versions:"
git --version
docker --version || echo "Docker: Not available (Docker Desktop needed)"
aws --version
python3 --version
bat --version
tree --version