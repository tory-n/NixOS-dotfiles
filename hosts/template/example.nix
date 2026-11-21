{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  
# ── Networking ──────────────────────────────────────────────────────
  networking.hostName = "user";
  networking.networkmanager.enable = true;
  
# ── Boot ────────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
# ── Hardware ────────────────────────────────────────────────────────
  hardware.enableRedistributableFirmware = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      Experimental = true;
      FastConnectable = true;
    };
  };
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:super";
  };

  # ── home management ────────────────────────────────────────────────
  home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.user = import ./home.nix;
          };

  
  # Do NOT change this after the initial install.
  system.stateVersion = "26.05";
}
