#!/bin/bash
# Installs everything this setup adds on top of a stock Omarchy install.
# Runs automatically after `yadm clone`, safe to re-run.
set -euo pipefail

repo_pkgs=(
  # Terminal & editors
  alacritty              # GPU-accelerated terminal emulator
  neovim                 # main editor
  vim                    # fallback editor for rescue shells
  visual-studio-code-bin # GUI editor

  # CLI tools
  yadm                # dotfiles manager (this repo)
  github-cli          # gh, also the git credential helper in .gitconfig
  googleworkspace-cli # gws, Drive/Gmail/Calendar from the shell

  # Development
  podman         # rootless OCI containers
  podman-compose # docker-compose.yml support for podman
  podman-desktop # container GUI

  # Desktop apps
  steam       # games
  voxtype-bin # push-to-talk voice-to-text

  # Fingerprint reader
  fprintd         # fingerprint reader D-Bus service
)

aur_pkgs=(
  brave-origin-bin         # browser
  bruno-bin                # API client
  libfprint-elanmoc2-git   # fingerprint driver patched for the ELAN 0C4C reader
  hyprmoncfg               # monitor profiles and auto-switching for Hyprland
)

echo "==> Installing packages from the Arch/Omarchy repos"
omarchy-pkg-add "${repo_pkgs[@]}"

echo "==> Installing packages from the AUR"
omarchy-pkg-aur-add "${aur_pkgs[@]}"

echo "==> Installing mise tools (~/.config/mise/config.toml)"
mise install

echo "==> Fetching yadm submodules (nvim config)"
yadm submodule update --init --recursive

echo "==> Done. Log out and back in to pick up group and shell changes."
echo "    Run ~/.config/yadm/setup-yubikey.sh with the YubiKey plugged in."
