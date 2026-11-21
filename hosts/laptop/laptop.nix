{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  users.users.toryn = {
    isNormalUser = true;
    description = "toryn";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "audio" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
# ── Networking ──────────────────────────────────────────────────────
  networking.hostName = "tori-1";
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
  home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.toryn = import ./home.nix;
          };

  # ── Power management ────────────────────────────────────────────────
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
