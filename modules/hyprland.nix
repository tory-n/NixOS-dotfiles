{ config, pkgs, lib, inputs, ... }:

{
  services.xserver.enable = true;
  
  services.displayManager.sddm.enable = false;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animate = false;
    };
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.dconf.enable = true;
  security.pam.services.hyprlock = { };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [

    # cool
    inputs.areofyl-fetch.packages.${pkgs.stdenv.hostPlatform.system}.default
    cmatrix
    cbonsai
    pipes

    # screenshot
    grim
    slurp
    
    # launcher / shell
    vicinae
    waybar
    
    # hyprland (hypridle via services.hypridle, portal via programs.hyprland)
    hyprpaper
    hyprlock
    
    # user apps
    nicotine-plus
    kew
    musescore
    discord
    obsidian
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    spotify
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
 
}
