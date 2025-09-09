#!/bin/bash

# install-core-apps.sh
# Installs essential productivity applications for general users (non-technical)

set -e  # Exit on any error

echo "📱 Installing Core Productivity Apps..."

# Check if Homebrew is available
if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew not found. Please run install-homebrew.sh first"
    exit 1
fi

echo "🎯 Installing productivity applications via Homebrew Cask..."

# Productivity & Communication Apps
CORE_APPS=(
    "notion"                    # Documentation and note-taking
    "linear-linear"             # Issue tracking and project management  
    "figma"                     # Design and wireframing
    "raycast"                   # Spotlight replacement with powerful extensions
    "typora"                    # Markdown editor
    "readdle-spark"             # Email client
    "slack"                     # Team communication
    "zoom"                      # Video conferencing
    "spotify"                   # Music streaming
    "keeper-password-manager"   # Password management
)

# Function to install apps with error handling
install_apps() {
    local app_list=("$@")
    for app in "${app_list[@]}"; do
        # Special case for raycast - check Applications folder too
        if [[ "$app" == "raycast" ]] && [[ -d "/Applications/Raycast.app" ]]; then
            echo "✅ raycast already installed (found in Applications) - skipping"
        elif brew list --cask "$app" >/dev/null 2>&1; then
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

echo "🚀 Installing Core Productivity Apps..."
install_apps "${CORE_APPS[@]}"

echo "🎉 Core Apps installation complete!"

echo "📋 Installed Applications:"
echo "📝 Productivity: Notion, Linear, Figma, Raycast, Typora"
echo "📧 Communication: Spark (email), Slack, Zoom"
echo "🎵 Entertainment: Spotify"
echo "🔐 Security: Keeper Password Manager"

echo "💡 Next Steps:"
echo "• Open Raycast and set up shortcuts"  
echo "• Configure Notion workspace"
echo "• Set up Slack workspaces"
echo "• Install browser extensions for productivity tools"

echo "📝 Check /Applications folder to verify all installations"