#!/bin/bash

# install-desktop-apps.sh
# Installs desktop applications for backend development and productivity

set -e  # Exit on any error

echo "🖥️  Installing Desktop Applications..."

# Check if Homebrew is available
if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew not found. Please run install-homebrew.sh first"
    exit 1
fi

echo "📱 Installing desktop applications via Homebrew Cask..."

# Development Tools
DEV_APPS=(
    "visual-studio-code"        # Free IDE for Node.js development
    "webstorm"                  # JetBrains IDE for web development (paid)
    "sublime-text"              # Lightweight text editor
    "iterm2"                    # Enhanced terminal
    "docker"                    # Docker Desktop (containerization)
    "postman"                   # API testing and development
)

# Database Tools
DB_APPS=(
    "tableplus"                 # Database management tool
    "mongodb-compass"           # MongoDB GUI
)

# Productivity Tools
PRODUCTIVITY_APPS=(
    "notion"                    # Documentation and note-taking
    "linear-linear"             # Issue tracking and project management
    "figma"                     # Design and wireframing
    "raycast"                   # Spotlight replacement with powerful extensions
    "typora"                    # Markdown editor
    "readdle-spark"             # Email client
)

# Communication Tools
COMM_APPS=(
    "slack"                     # Team communication
    "zoom"                      # Video conferencing
    "spotify"                   # Music (for coding sessions!)
)

# Security Tools
SECURITY_APPS=(
    "keeper-password-manager"   # Password management
)

# Function to install apps with error handling
install_apps() {
    local app_list=("$@")
    for app in "${app_list[@]}"; do
        if brew list --cask "$app" >/dev/null 2>&1; then
            echo "✅ $app already installed"
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

echo "🛠️  Installing Development Tools..."
install_apps "${DEV_APPS[@]}"

echo "🗄️  Installing Database Tools..."
install_apps "${DB_APPS[@]}"

echo "⚡ Installing Productivity Tools..."
install_apps "${PRODUCTIVITY_APPS[@]}"

echo "💬 Installing Communication Tools..."
install_apps "${COMM_APPS[@]}"

echo "🔐 Installing Security Tools..."
install_apps "${SECURITY_APPS[@]}"

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

echo "🎉 Desktop Applications installation complete!"

echo "📋 Installed Applications:"
echo "Development: VS Code, WebStorm, Sublime Text, iTerm2, Docker Desktop, Postman"
echo "Database: TablePlus, MongoDB Compass, NoSQL Workbench"  
echo "Productivity: Notion, Linear, Figma, Raycast, Typora, Spark"
echo "Communication: Slack, Zoom, Spotify"
echo "Security: Keeper Password Manager"

echo "⚠️  Note: Some applications may require licenses (WebStorm, Typora, etc.)"
echo "📝 Check /Applications folder to verify all installations"