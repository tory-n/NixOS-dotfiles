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
  services.fwupd.enable = true;
  services.fstrim.enable = true;
# ── User ────────────────────────────────────────────────────────────
  
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
  programs.nh = {
    enable = true;
    flake = "/home/toryn/NixOS-dotfiles";
    clean = {
    enable = true;
    extraArgs = "--keep-since 7d --keep 5";
    };
  };
  nix.optimise.automatic = true;
  boot.loader.systemd-boot.configurationLimit = 10;
# ── utilities and packages  ─────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    brightnessctl
    fastfetch
    gh
    git
    jq
    kitty
    localsend
    lua-language-server
    nautilus
    nemo
    neovim
    networkmanagerapplet
    nixd
    obs-studio
    onlyoffice-desktopeditors
    pavucontrol
    playerctl
    shotcut
    unzip
    vlc
    wl-clipboard
    (pkgs.python3.withPackages (ps: [
      ps.sympy
    ]))
  ];
}
