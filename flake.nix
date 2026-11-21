{
  description = "NixOS configuration for all of tori's devices";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-26.05";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    areofyl-fetch.url = "github:areofyl/fetch";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    septabee-nix = {
      url = "github:JuxGD/septabee-nix";
    };   
    hyprglass = {
      url = "github:janquednau/hyprglass/nix-support";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    owly.url = "github:t4t5/owly";
    spotifast.url = "github:crmne/spotifast";   
    musnix.url = "github:musnix/musnix";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, musnix,  septabee-nix, owly, ... }: {
# device 1: Thinkpad L13 gen $
    nixosConfigurations.tori-1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      
      modules = [
        inputs.home-manager.nixosModules.home-manager 
        ./hosts/laptop/laptop.nix
        ./modules/hyprland.nix
        ./modules/music.nix
        ./modules/common.nix
        
      ];
    };
  };
}
