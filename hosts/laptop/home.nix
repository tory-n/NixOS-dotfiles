{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../home/hyprland-home.nix
    ../../home/gtk-home.nix
  ];

  home.username = "toryn";
  home.homeDirectory = "/home/toryn";
  home.stateVersion = "26.05";

  home.packages = [
    pkgs.ripgrep
  ];

  # laptop-only (battery alerts)
  services.poweralertd.enable = true;
}
