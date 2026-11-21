{ config, pkgs, lib, inputs, ... }:
{
imports = [
    inputs.musnix.nixosModules.musnix
    inputs.septabee-nix.nixosModules.default
  ];
# Software
  environment.systemPackages = with pkgs; [
    reaper
    lsp-plugins
    calf
    surge-xt
    vital
    carla
    zam-plugins
    odin2
    sfizz
    neural-amp-modeler-lv2
    mda_lv2
    decent-sampler
    pipewire.jack
  ];
# Config
  musnix = {
    enable          = true;
    rtcqs.enable    = true;
    # kernel.realtime = true;  # compiles the kernel locally; slow
  };

  security.rtkit.enable = true;
  programs.septabee = {
    enable = true;
    waylandSupport = true;
  };
}
  
