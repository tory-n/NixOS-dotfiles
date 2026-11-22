{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../home/hyprland-home.nix
    ../../home/gtk-home.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "26.05";

  home.packages = [
    pkgs.ripgrep
  ];

  home.file."Documents/Obsidian Vault/source".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS-dotfiles";

  # laptop-only (battery alerts)
  services.poweralertd.enable = true;
}
