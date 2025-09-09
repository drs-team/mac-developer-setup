# 🍎 Mac Developer Setup

Automated setup scripts for configuring a complete backend development environment on macOS. Perfect for new Macs or clean installations.

## 🚀 Quick Start

```bash
# Clone or download the scripts
curl -sSL https://raw.githubusercontent.com/your-repo/mac-developer-setup/main/setup.sh | bash

# Or run locally
git clone https://github.com/your-repo/mac-developer-setup.git
cd mac-developer-setup
chmod +x *.sh
./setup.sh
```

## 📦 What Gets Installed

### Command Line Tools
- **Homebrew** - macOS package manager
- **Git** - Version control
- **Docker** - Containerization CLI
- **AWS CLI** - Amazon Web Services command line interface
- **Node.js** (via nvm) - JavaScript runtime
- **Python 3.12** - Programming language
- **Modern CLI tools**: `bat`, `tree`, `httpie`, `jq`, `fzf`, `ripgrep`

### Development Environment
- **NVM** - Node Version Manager
- **npm, yarn, pnpm** - Package managers
- **Global packages**: TypeScript, ESLint, Prettier, PM2, AWS CDK, Serverless

### Desktop Applications
- **IDEs**: Visual Studio Code, WebStorm, Sublime Text
- **Terminal**: iTerm2
- **API Testing**: Postman
- **Database Tools**: TablePlus, MongoDB Compass, NoSQL Workbench
- **Productivity**: Notion, Linear, Figma, Raycast, Typora
- **Communication**: Slack, Zoom, Spark (email)
- **Security**: Keeper Password Manager
- **Entertainment**: Spotify

### Shell Configuration
- **oh-my-zsh** with useful plugins
- **Custom aliases** for development workflows
- **Enhanced history** and auto-completion
- **NVM integration** with automatic version switching

## 📋 Usage Options

### 1. Full Setup (Recommended)
```bash
./setup.sh
# Choose option 1 - installs everything
```

### 2. Selective Setup
```bash
./setup.sh
# Choose option 2 - pick and choose components
```

### 3. Quick Setup (Essentials Only)
```bash
./setup.sh
# Choose option 3 - CLI tools and development environment only
```

### 4. Individual Scripts
```bash
# Install specific components
./install-homebrew.sh          # Package manager only
./install-cli-tools.sh         # Command line tools
./setup-development.sh         # Node.js environment
./configure-shell.sh           # Shell customization
./install-desktop-apps.sh      # GUI applications
```

## 🛠️ Individual Script Details

### `install-homebrew.sh`
- Installs Homebrew package manager
- Configures PATH for Apple Silicon Macs
- Verifies installation

### `install-cli-tools.sh`
- Essential command line development tools
- Modern replacements for Unix utilities
- Xcode Command Line Tools
- Python development environment

### `setup-development.sh`
- NVM (Node Version Manager) installation
- Latest LTS Node.js version
- Global npm packages for development
- Package managers (npm, yarn, pnpm)

### `configure-shell.sh`
- oh-my-zsh installation and configuration
- Development-focused plugins
- Useful aliases and functions
- Enhanced shell experience

### `install-desktop-apps.sh`
- IDEs and editors
- Database management tools
- Communication apps
- Productivity tools
- Manual installation of NoSQL Workbench

## 🔧 Customization

### Adding Your Own Tools

Edit the arrays in each script to add/remove tools:

```bash
# In install-cli-tools.sh
CLI_TOOLS=(
    "git"
    "docker"
    "your-tool-here"  # Add your tools
)

# In install-desktop-apps.sh  
DEV_APPS=(
    "visual-studio-code"
    "your-app-here"   # Add your apps
)
```

### Shell Customization

Edit `configure-shell.sh` to modify:
- Aliases and functions
- oh-my-zsh plugins
- Theme selection
- Environment variables

## 📚 Post-Installation Setup

After running the scripts, complete these manual steps:

### 1. Git Configuration
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global init.defaultBranch main
```

### 2. AWS Configuration
```bash
aws configure
# Enter your AWS credentials
```

### 3. SSH Key Generation
```bash
ssh-keygen -t ed25519 -C "your@email.com"
# Add to GitHub/GitLab/Bitbucket
```

### 4. Shell Restart
```bash
# Restart terminal or
source ~/.zshrc
```

### 5. Application Licenses
Some applications require licenses:
- **WebStorm**: JetBrains license ($59/year)
- **Typora**: One-time purchase ($14.99)

## 🎯 Useful Commands & Aliases

The setup includes these handy aliases:

### Development
```bash
# Node.js
ni          # npm install
ns          # npm start
nt          # npm test
nrd         # npm run dev

# Git
gs          # git status
ga          # git add
gc          # git commit
gp          # git push
gl          # git log --oneline

# Docker
dk          # docker
dkc         # docker-compose
dkps        # docker ps

# AWS
awsp        # export AWS_PROFILE=
awsl        # aws s3 ls
```

### System
```bash
ll          # ls -alF
cat         # bat (with syntax highlighting)
grep        # rg (ripgrep)
reload      # source ~/.zshrc
```

### Custom Functions
```bash
mkcd dirname        # Create and enter directory
killport 3000      # Kill process on port 3000
gac "message"      # Git add all and commit
extract file.zip   # Extract various archive formats
weather london     # Get weather forecast
myip              # Show current IP address
```

## 🔍 NVM Usage

Manage Node.js versions easily:

```bash
# Install and use specific versions
nvm install 18.17.0
nvm use 18.17.0
nvm alias default 18.17.0

# List versions
nvm ls              # Installed versions
nvm ls-remote       # Available versions

# Auto-switch with .nvmrc
echo "18.17.0" > .nvmrc
cd project-folder   # Automatically switches to v18.17.0
```

## 🐛 Troubleshooting

### Homebrew Permission Issues
```bash
sudo chown -R $(whoami) /opt/homebrew/
```

### Command Not Found After Installation
```bash
# Reload shell configuration
source ~/.zshrc

# Or restart terminal
```

### NVM Not Working
```bash
# Ensure it's in your PATH
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
source ~/.zshrc
```

### Docker Desktop Issues
- Install manually from Docker website if Homebrew installation fails
- Grant necessary permissions in System Preferences

## 🔐 Security Notes

- Scripts use official installation methods
- No credentials are stored
- Review scripts before running on production machines
- Some apps may require security permissions

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on a fresh macOS installation
5. Submit a pull request

## 📄 License

MIT License - feel free to modify and distribute.

## ⭐ Support

If this helped you set up your Mac, consider giving it a star!

---

**Made with ❤️ for the developer community**

*Tested on macOS Ventura, Sonoma, and Sequoia (Apple Silicon)*