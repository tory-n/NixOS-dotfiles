{ config, pkgs, lib, inputs, ... }:

{
  services.xserver.enable = true;
  
  services.displayManager.sddm.enable = false;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animate = true;
      animation = "dur_file";
      dur_file_path = "${./rain.dur}";
      full_color = true;
      dur_x_offset = 0;
      dur_y_offset = 0;
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
    # utility
    networkmanagerapplet
    brightnessctl
    wl-clipboard
    kitty
    git
    jq
    nemo
    thunar
    nautilus
    localsend
    pavucontrol
    vlc
    obs-studio
    shotcut
    bitwarden-desktop
    polkit_gnome
    (pkgs.python3.withPackages (ps: [
      ps.sympy
    ]))
    unzip
    git


    # cool
    inputs.areofyl-fetch.packages.${pkgs.stdenv.hostPlatform.system}.default
    fastfetch
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
