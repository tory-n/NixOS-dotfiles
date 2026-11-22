# NixOS-dotfiles
Custom configuration for Hyprland and NixOS

Per device configurations are under hosts. I currently only have configured one device with NixOS, but I have plans to attempt to run NixOS on a 2013 Mac Pro as a home gaming device, and for running headless VMs.

Hyprland and waybar configurations are included. Install your own wallpaper and configure Hyprpaper or your wallpaper manager of choice.

At the time of writing, the rose-pine theme was in use, but I expect to change it and forget to update.

# Showcase
<img src="https://github.com/user-attachments/assets/e2686426-5776-43f2-93c1-97b45bd159cc" />

## Install
Run the following commands to install the template configuration on your device with all modules enabled.

```
git clone https://github.com/tory-n/NixOS-dotfiles

cd NixOS-dotfiles
cd ./NixOS-dotfiles

cp /etc/nixos/hardware-configuration.nix ./hosts/template/hardware-configuration.nix

# if the above fails
nixos-generate-config --show-hardware-config > hosts/template/hardware-configuration.nix

sudo nixos-rebuild switch --flake ".#user"
```

# Configuration
if you really like what I did and want to copy what I have done, which I advise against, clone this repo onto your device and write your own device configuration, home manager file and flake module.

## home.nix config

```
{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../home/hyprland-home.nix
    ../../home/gtk-home.nix
    # these are the only two available currently
  ];

  home.username = "your-username";
  home.homeDirectory = "/home/your-username";
  home.stateVersion = "write whatever is correct";

  home.packages = [
    pkgs.ripgrep
  ];
  
  # this allows me to edit my config from within obsidian. you need the obsidian plugin Onyx or similar to make this work.
  home.file."Documents/Obsidian Vault/source".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config";

  # laptop-only (battery alerts)
  services.poweralertd.enable = true;
}
```
## per-device config

```
{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    # should be auto-generated, move to the same folder as this.
  ];
  
# ── Networking ──────────────────────────────────────────────────────
  networking.hostName = "your-username";
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

  # ── Fingerprint ─────────────────────────────────────────────────────
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = false;
  security.pam.services.sudo.fprintAuth  = true;
  security.pam.services.ly.fprintAuth    = false;
security.pam.services.sudo.rules.auth.fprintd.settings.timeout = 5;
  security.pam.services.polkit-1.fprintAuth = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "net.reactivated.fprint.device.enroll" &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';
  
  # ── home management ────────────────────────────────────────────────
  # This is what manages everything in the home folder (of the repo, not your device), and also your device config files for hyprland. 
  home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.toryn = import ./home.nix;
          };
          
  # ── Power management ────────────────────────────────────────────────
  # I configured very aggressive power management because of my degraded laptop battery and to prevent overheating. 
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC  = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_SCALING_GOVERNOR_ON_AC  = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_HWP_DYN_BOOST_ON_AC  = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      CPU_MIN_PERF_ON_AC  = 0;
      CPU_MAX_PERF_ON_AC  = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;
    };
  };

  services.logind.settings.Login = {
    HandleLidSwitch              = "suspend"; # on battery
    HandleLidSwitchExternalPower = "lock";    # on AC
    HandleLidSwitchDocked        = "lock";
    HandlePowerKey               = "ignore";
  };
  
  # Do NOT change this after the initial install.
  system.stateVersion = "26.05";
}
```
### flake.nix 
```
nixosConfigurations.tori-1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      
      modules = [
        inputs.home-manager.nixosModules.home-manager 
        ./hosts/your-own-path/your-file.nix
        
# You have to configure your own DE if you don't want to use hyprland. 
# Remember to include a display manager as SDDM is disabled by default.
        ./modules/hyprland.nix
        
# if you want to do music production you need this
        ./modules/music.nix
        
# most utilities and basic apps are installed here.
# keep in mind that my idea of utilities is things i myself use (duh)
        ./modules/common.nix
        
      ];
    };
```

