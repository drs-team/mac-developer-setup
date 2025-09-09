#!/bin/bash

# install-development-tools.sh
# Installs development tools and applications for technical users

set -e  # Exit on any error

echo "💻 Installing Development Tools..."

# Check if Homebrew is available
if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew not found. Please run install-homebrew.sh first"
    exit 1
fi

echo "🛠️ Installing development applications and tools..."

# Development IDEs and Editors
DEV_APPS=(
    "visual-studio-code"        # Free IDE for development
    "webstorm"                  # JetBrains IDE for web development (paid)
    "sublime-text"              # Lightweight text editor
    "iterm2"                    # Enhanced terminal
    "postman"                   # API testing and development
)

# Development Desktop Apps
DEV_DESKTOP_APPS=(
    "docker"                    # Docker Desktop (containerization)
)

# Database Tools
DB_APPS=(
    "tableplus"                 # Database management tool
    "mongodb-compass"           # MongoDB GUI
)

# Function to install apps with error handling
install_apps() {
    local app_list=("$@")
    for app in "${app_list[@]}"; do
        if brew list --cask "$app" >/dev/null 2>&1; then
            echo "✅ $app already installed - skipping"
        else
            echo "📥 Installing $app..."
            if brew install --cask "$app"; then
                echo "✅ $app installed successfully"
            else
                echo "⚠️  Failed to install $app (might require manual installation)"
            fi
        fi
    done
}

echo "📝 Installing Development IDEs and Editors..."
install_apps "${DEV_APPS[@]}"

echo "🐳 Installing Development Desktop Apps..."
install_apps "${DEV_DESKTOP_APPS[@]}"

echo "🗄️ Installing Database Tools..."
install_apps "${DB_APPS[@]}"

echo "🎯 Installing NoSQL Workbench (manual download)..."
if [[ -d "/Applications/NoSQL Workbench.app" ]]; then
    echo "✅ NoSQL Workbench already installed"
else
    echo "📥 Downloading NoSQL Workbench for Apple Silicon..."
    curl -L "https://dy9cqqaswpltd.cloudfront.net/NoSQL_Workbench-arm64.dmg" -o /tmp/NoSQL_Workbench.dmg
    
    echo "🔧 Installing NoSQL Workbench..."
    hdiutil attach /tmp/NoSQL_Workbench.dmg -quiet
    cp -R "/Volumes/NoSQL Workbench"*"/NoSQL Workbench.app" /Applications/
    hdiutil detach "/Volumes/NoSQL Workbench"* -quiet
    rm /tmp/NoSQL_Workbench.dmg
    echo "✅ NoSQL Workbench installed successfully"
fi

echo "🎉 Development Tools installation complete!"

echo "📋 Installed Development Applications:"
echo "💻 IDEs/Editors: VS Code, WebStorm, Sublime Text"
echo "🖥️ Terminal: iTerm2"
echo "🌐 API Testing: Postman"
echo "🐳 Containerization: Docker Desktop"
echo "🗄️ Database: TablePlus, MongoDB Compass, NoSQL Workbench"

echo "💡 Next Steps for Developers:"
echo "• Configure VS Code extensions (GitLens, ES7 React/Redux, etc.)"
echo "• Set up Docker Desktop and sign in"
echo "• Import Postman collections"
echo "• Configure database connections in TablePlus"
echo "• Set up iTerm2 themes and profiles"

echo "⚠️  Note: WebStorm requires a JetBrains license"
echo "📝 Check /Applications folder to verify all installations"