#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/tory-n/NixOS-dotfiles"
TARGET_DIR="$HOME/NixOS-dotfiles"

if ! command -v git >/dev/null; then
  exec nix-shell -p git --run "bash $0"
fi

export NIX_CONFIG="experimental-features = nix-command flakes"

git clone "$REPO_URL" "$TARGET_DIR"
cd "$TARGET_DIR"

if [ -f /etc/nixos/hardware-configuration.nix ]; then
  cp /etc/nixos/hardware-configuration.nix hosts/template/hardware-configuration.nix
else
  nixos-generate-config --show-hardware-config > hosts/template/hardware-configuration.nix
fi
git add hosts/template/hardware-configuration.nix  

sudo nixos-rebuild switch --flake ".#user"

# EXPERIMENTAL.
# DO NOT USE
