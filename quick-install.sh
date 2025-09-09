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
    
    # Generate installation summary
    echo "📊 INSTALLATION SUMMARY"
    echo "========================"
    echo
    echo "✅ SUCCESSFULLY INSTALLED:"
    
    # Check Homebrew
    if command -v brew >/dev/null 2>&1; then
        echo "• ✅ Homebrew ($(brew --version | head -1))"
    fi
    
    # Check oh-my-zsh
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo "• ✅ oh-my-zsh with plugins and themes"
    fi
    
    # Check applications
    local installed_apps=()
    local failed_apps=()
    local app_checks=(
        "notion:Notion.app:Notion"
        "linear-linear:Linear.app:Linear"
        "figma:Figma.app:Figma"
        "raycast:Raycast.app:Raycast"
        "typora:Typora.app:Typora"
        "readdle-spark:Spark Desktop.app:Spark Email"
        "slack:Slack.app:Slack"
        "zoom:zoom.us.app:Zoom"
        "spotify:Spotify.app:Spotify"
        "keeper-password-manager:Keeper Password Manager.app:Keeper"
    )
    
    for app_info in "${app_checks[@]}"; do
        IFS=':' read -r cask_name app_name display_name <<< "$app_info"
        if [[ -d "/Applications/$app_name" ]]; then
            installed_apps+=("$display_name")
            echo "• ✅ $display_name"
        else
            failed_apps+=("$display_name")
        fi
    done
    
    if [ ${#failed_apps[@]} -gt 0 ]; then
        echo
        echo "⚠️  NOT INSTALLED (manual installation needed):"
        for app in "${failed_apps[@]}"; do
            echo "• ❌ $app"
        done
        echo
        echo "💡 To install missing apps manually:"
        for app_info in "${app_checks[@]}"; do
            IFS=':' read -r cask_name app_name display_name <<< "$app_info"
            if [[ ! -d "/Applications/$app_name" ]]; then
                echo "   brew install --cask $cask_name  # for $display_name"
            fi
        done
    fi
    
    echo
    echo "📈 INSTALLATION STATS:"
    echo "• Total apps attempted: ${#app_checks[@]}"
    echo "• Successfully installed: ${#installed_apps[@]}"
    echo "• Failed installations: ${#failed_apps[@]}"
    
    echo
    echo "🔄 NEXT STEPS:"
    echo "1. Restart your terminal or run: source ~/.zshrc"
    echo "2. Open installed applications and complete setup"
    if [ ${#failed_apps[@]} -gt 0 ]; then
        echo "3. Install missing apps using the commands above"
    fi
    echo
    echo "💻 Want development tools? Run:"
    echo "git clone https://github.com/drs-team/mac-developer-setup.git"
    echo "cd mac-developer-setup && ./setup.sh"
    echo
    print_status "Happy productivity! 🚀"
}

# Run main function
main