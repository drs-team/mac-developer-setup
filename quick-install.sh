#!/bin/bash

# quick-install.sh
# Non-interactive installation script for curl piping

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE} $1${NC}"
    echo -e "${PURPLE}================================${NC}"
}

# Download and run script function
download_and_run() {
    local script_name=$1
    local description=$2
    
    print_status "Running $description..."
    curl -sSL "https://raw.githubusercontent.com/drs-team/mac-developer-setup/main/$script_name" | bash
}

# Main installation
main() {
    print_header "🍎 MAC DEVELOPER SETUP - QUICK INSTALL"
    
    echo -e "${BLUE}Installing essential productivity tools...${NC}"
    echo
    
    # Run core installation scripts
    download_and_run "install-homebrew.sh" "Homebrew installation"
    download_and_run "configure-shell.sh" "Shell configuration"  
    download_and_run "install-core-apps.sh" "Core productivity apps"
    
    print_header "🎉 QUICK SETUP COMPLETE!"
    
    echo -e "${GREEN}Your Mac is now configured with essential productivity tools!${NC}"
    echo
    echo "📋 What was installed:"
    echo "• Package manager: Homebrew"
    echo "• Enhanced shell: oh-my-zsh with plugins"
    echo "• Productivity: Notion, Linear, Figma, Raycast, Typora"
    echo "• Communication: Slack, Zoom, Spark (email)"
    echo "• Security: Keeper Password Manager"
    echo "• Entertainment: Spotify"
    echo
    echo "🔄 Next steps:"
    echo "1. Restart your terminal or run: source ~/.zshrc"
    echo "2. Open applications and complete setup"
    echo
    echo "💻 Want development tools? Run:"
    echo "git clone https://github.com/drs-team/mac-developer-setup.git"
    echo "cd mac-developer-setup && ./setup.sh"
    echo
    print_status "Happy productivity! 🚀"
}

# Run main function
main