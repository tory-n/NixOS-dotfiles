{
  description = "NixOS configuration for all of tori's devices";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-26.05";
    
    # firefox based browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # cool animation
    areofyl-fetch.url = "github:areofyl/fetch";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # experimental music production software
    septabee-nix = {
      url = "github:JuxGD/septabee-nix";
    };   

    # glassy hyprland effect
    hyprglass = {
      url = "github:janquednau/hyprglass/nix-support";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # airdrop for linux
    owly.url = "github:t4t5/owly";

    # audio driver configuration  
    musnix.url = "github:musnix/musnix";
    
  };
  outputs = inputs@{ self, nixpkgs, home-manager, musnix,  septabee-nix, owly, ... }: {
    # this block is for my only nixOS device
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
      nixosConfigurations.user = nixpkgs.lib.nixosSystem {
    
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      
      modules = [
        inputs.home-manager.nixosModules.home-manager 
        ./hosts/template/example.nix
        ./modules/hyprland.nix
        ./modules/music.nix
        ./modules/common.nix 
      ];
    };
  };
}
