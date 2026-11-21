{ config, pkgs, lib, inputs, ... }:
{
imports = [
    inputs.owly.nixosModules.default
  ];
  time.timeZone = "Asia/Singapore";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_PAPER       = "en_GB.UTF-8"; # A4
    LC_MEASUREMENT = "en_GB.UTF-8"; # metric
    LC_TIME        = "en_GB.UTF-8"; # 24h, DD/MM
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        qt6Packages.fcitx5-chinese-addons
        fcitx5-gtk
      ];
    };
  };
  environment.sessionVariables.XMODIFIERS = "@im=fcitx";
# ── User ────────────────────────────────────────────────────────────
  users.users.toryn = {
    isNormalUser = true;
    description = "toryn";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "audio" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  services.flatpak.enable = true;
  programs.fish.enable = true;
  services.desktopManager.plasma6.enable = true;
  
# ── Printing / scanning ─────────────────────────────────────────────
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
# ── font packages ─────────────────────────────────────────────
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      googlesans-code
      (google-fonts.override { fonts = [ "LINE Seed JP" ]; })
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      wqy_zenhei
      wqy_microhei
      sarasa-gothic
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "LINE Seed JP" ];
        monospace = [ "Google Sans Code" ];
      };
    };
  };
# ── airdrop and nix ─────────────────────────────────────────────
  # Owly (AirDrop protocol)
  services.owly = {
    enable = true;
    settings.allow_untested = true;
  };
  
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };
# ── utilities and packages  ─────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    # utility
    networkmanagerapplet
    brightnessctl
    wl-clipboard
    kitty
    fastfetch
    git
    gh
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
    onlyoffice-desktopeditors
  ];
}
