#!/bin/bash
set -euo pipefail

cd "$HOME"

echo "🚀 Starting bootstrap..."
echo ""
echo "🐧 Detecting system..."
echo "   System: $(uname -s)"
echo "   Host:   $(hostname)"
echo "   User:   $(whoami)"
echo ""

echo "📦 Installing core packages..."
echo "   git, curl, wget, unzip, htop, ripgrep, fd-find,"
echo "   tmux, zsh, stow, jq, fzf, build-essential"
echo ""

echo "🖥️  Installing desktop packages..."
echo "   firefox, alacritty, thunar"
echo ""

echo "📦 Setting up Flatpak..."
echo "   Adding flathub remote"
echo ""

echo "🐚 Setting default shell to zsh..."
echo ""

echo "🔑 Generating SSH key..."
echo "   Type: ed25519"
echo "   Path: ~/.ssh/id_ed25519"
echo ""

echo "📁 Creating directories..."
echo "   ~/Projects"
echo "   ~/Downloads"
echo "   ~/Documents"
echo "   ~/Pictures/Screenshots"
echo ""

echo "🔗 Initializing yadm submodules..."
echo ""

echo "✅ Bootstrap complete!"
