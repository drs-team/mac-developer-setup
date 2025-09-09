#!/bin/bash

# setup.sh
# Main orchestrator script for Mac Developer Setup
# Runs all setup scripts in the correct order with user interaction

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE} $1${NC}"
    echo -e "${PURPLE}================================${NC}"
}

# Function to ask user for confirmation
ask_user() {
    while true; do
        read -p "$(echo -e ${CYAN}$1${NC}) [y/n]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Function to run script with error handling
run_script() {
    local script_name=$1
    local description=$2
    
    if [[ -f "$script_name" ]]; then
        print_status "Running $description..."
        if bash "$script_name"; then
            print_status "✅ $description completed successfully"
        else
            print_error "❌ $description failed"
            return 1
        fi
    else
        print_error "❌ Script $script_name not found"
        return 1
    fi
}

# Main setup function
main() {
    print_header "🍎 MAC DEVELOPER SETUP"
    
    echo -e "${BLUE}This script will set up a complete backend development environment on your Mac.${NC}"
    echo
    echo "It will install:"
    echo "• Homebrew package manager"
    echo "• Command line tools (git, docker, aws-cli, etc.)"
    echo "• Desktop applications (VS Code, WebStorm, Postman, etc.)"
    echo "• Node.js development environment (nvm, yarn, pnpm)"
    echo "• Enhanced shell configuration (oh-my-zsh)"
    echo
    
    if ! ask_user "Do you want to continue with the full setup?"; then
        echo "Setup cancelled by user."
        exit 0
    fi

    print_header "📋 SETUP MENU"
    
    echo "Choose your setup options:"
    echo "1. Full Setup (recommended for new Macs)"
    echo "2. Selective Setup (choose individual components)"
    echo "3. Quick Setup (essential tools only)"
    echo
    
    read -p "Enter your choice (1-3): " choice
    
    case $choice in
        1)
            full_setup
            ;;
        2)
            selective_setup
            ;;
        3)
            quick_setup
            ;;
        *)
            print_error "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Full setup - everything
full_setup() {
    print_header "🚀 FULL SETUP"
    
    run_script "install-homebrew.sh" "Homebrew installation"
    run_script "install-cli-tools.sh" "CLI tools installation"
    run_script "setup-development.sh" "Development environment setup"
    run_script "configure-shell.sh" "Shell configuration"
    run_script "install-desktop-apps.sh" "Desktop applications installation"
    
    setup_complete
}

# Selective setup - let user choose
selective_setup() {
    print_header "🎯 SELECTIVE SETUP"
    
    if ask_user "Install Homebrew package manager?"; then
        run_script "install-homebrew.sh" "Homebrew installation"
    fi
    
    if ask_user "Install command line tools (git, docker, aws-cli, etc.)?"; then
        run_script "install-cli-tools.sh" "CLI tools installation"
    fi
    
    if ask_user "Setup Node.js development environment (nvm, yarn, pnpm)?"; then
        run_script "setup-development.sh" "Development environment setup"
    fi
    
    if ask_user "Configure enhanced shell (oh-my-zsh, aliases, plugins)?"; then
        run_script "configure-shell.sh" "Shell configuration"
    fi
    
    if ask_user "Install desktop applications (VS Code, WebStorm, Postman, etc.)?"; then
        run_script "install-desktop-apps.sh" "Desktop applications installation"
    fi
    
    setup_complete
}

# Quick setup - essentials only
quick_setup() {
    print_header "⚡ QUICK SETUP"
    
    run_script "install-homebrew.sh" "Homebrew installation"
    run_script "install-cli-tools.sh" "CLI tools installation"
    run_script "setup-development.sh" "Development environment setup"
    
    print_status "Quick setup complete! You can run individual scripts later for more tools."
    
    if ask_user "Would you like to configure the shell environment now?"; then
        run_script "configure-shell.sh" "Shell configuration"
    fi
    
    setup_complete
}

# Setup completion message
setup_complete() {
    print_header "🎉 SETUP COMPLETE!"
    
    echo -e "${GREEN}Your Mac is now configured for backend development!${NC}"
    echo
    echo "📋 What's been installed:"
    echo "• Package manager: Homebrew"
    echo "• Version control: Git"
    echo "• Runtime: Node.js (via nvm)"
    echo "• Package managers: npm, yarn, pnpm"
    echo "• Cloud tools: AWS CLI, Docker"
    echo "• Development tools: VS Code, WebStorm, Postman"
    echo "• Database tools: TablePlus, MongoDB Compass, NoSQL Workbench"
    echo "• Shell: oh-my-zsh with plugins and aliases"
    echo
    echo "🔄 Next steps:"
    echo "1. Restart your terminal or run: source ~/.zshrc"
    echo "2. Configure your git: git config --global user.name 'Your Name'"
    echo "3. Configure your git: git config --global user.email 'your@email.com'"
    echo "4. Set up AWS credentials: aws configure"
    echo "5. Open applications and complete any required setup"
    echo
    echo "📚 Useful commands:"
    echo "• nvm ls                  - List Node.js versions"
    echo "• brew list              - List installed packages"
    echo "• alias                  - Show all available aliases"
    echo
    echo "🆘 Need help? Check README.md or run individual scripts with --help"
    echo
    print_status "Happy coding! 🚀"
}

# Show help
show_help() {
    echo "Mac Developer Setup - Automated development environment setup"
    echo
    echo "Usage: ./setup.sh [OPTIONS]"
    echo
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  --version      Show version information"
    echo
    echo "Individual scripts:"
    echo "  ./install-homebrew.sh      - Install Homebrew package manager"
    echo "  ./install-cli-tools.sh     - Install command line tools"
    echo "  ./setup-development.sh     - Setup Node.js development environment"
    echo "  ./configure-shell.sh       - Configure shell with oh-my-zsh"
    echo "  ./install-desktop-apps.sh  - Install desktop applications"
    echo
    echo "Examples:"
    echo "  ./setup.sh                 - Interactive setup"
    echo "  ./install-homebrew.sh      - Install only Homebrew"
    echo
}

# Check command line arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    --version)
        echo "Mac Developer Setup v1.0.0"
        exit 0
        ;;
    "")
        main
        ;;
    *)
        print_error "Unknown option: $1"
        show_help
        exit 1
        ;;
esac