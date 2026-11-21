# Hyprland session: compositor config, idle/lock, notifications.
{ config, pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    plugins = [
      "${inputs.hyprglass.packages.${pkgs.stdenv.hostPlatform.system}.hyprglass-nixpkgs}/lib/libhyprglass.so"
    ];
    extraConfig = builtins.readFile ./hyprland.lua;
  };
  # ~/.config/hypr/conf -> /etc/nixos/hypr/conf
  xdg.configFile."hypr/conf".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/hypr/conf";

  home.file."${config.home.homeDirectory}/.config/waybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/waybar";

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 90;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  services.mako = {
    enable = true;
    settings = {
      font = "LINE Seed JP 11";
      width = 360;
      height = 150;
      margin = "12";
      padding = "14";
      border-size = 2;
      border-radius = 12;
      icons = true;
      max-icon-size = 48;
      default-timeout = 6000;
      layer = "overlay";

      background-color = "#191724f2";
      text-color = "#e0def4";
      border-color = "#6e6a86";
      progress-color = "over #524f67";

      "urgency=low" = {
        border-color = "#908caa";
      };
      "urgency=high" = {
        border-color = "#ebbcba";
        text-color = "#e0def4";
        default-timeout = 0;
      };
    };
  };
}
