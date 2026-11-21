#!/usr/bin/env bash
# New-device installer. Clone the repo yourself, then run this from inside it.
# Adds this machine's hardware config to hosts/template/ and rebuilds as "user".
set -euo pipefail

# Work from the repo root (the folder this script lives in)
cd "$(dirname "$(readlink -f "$0")")"

export NIX_CONFIG="experimental-features = nix-command flakes"

# 1. Put this machine's hardware config in hosts/template/
if [ -f /etc/nixos/hardware-configuration.nix ]; then
  cp /etc/nixos/hardware-configuration.nix hosts/template/hardware-configuration.nix
else
  nixos-generate-config --show-hardware-config > hosts/template/hardware-configuration.nix
fi
git add hosts/template/hardware-configuration.nix  # flakes ignore untracked files

# 2. Rebuild using the "user" output (hosts/template/example.nix)
sudo nixos-rebuild switch --flake ".#user"
# EXPERIMENTAL.
# DO NOT USE
