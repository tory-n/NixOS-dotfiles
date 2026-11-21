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
  programs.dconf.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
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
    fuzzel
    waybar
    nwg-dock-hyprland
    nwg-drawer
    
    # hyprland (hypridle via services.hypridle, portal via programs.hyprland)
    hyprpaper
    hyprlock
    
    # user apps
    nicotine-plus
    kew
    musescore
    onlyoffice-desktopeditors
    discord
    obsidian
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    spotify
  ];

 
}
