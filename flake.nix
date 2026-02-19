{
  description = "Nixos config flake";

  inputs = {
    # linux dependencies
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # darwin dependencies
    nixpkgs-darwin = {
      url = "github:NixOS/nixpkgs/nixos-25.11";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    home-manager-darwin = {
      url = "github:nix-community/home-manager/update/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    {
      darwinConfigurations = {
        m3 = inputs.darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/m3
            inputs.home-manager-darwin.darwinModules.default
          ];
        };
      };
      nixosConfigurations = {
        macbookpro = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/macbookpro
            inputs.home-manager.nixosModules.default
          ];
        };
        pc = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/pc
            inputs.home-manager.nixosModules.default
          ];
        };
        pi = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/pi
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}

