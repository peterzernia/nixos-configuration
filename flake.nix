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
    darwin = {
      url = "github:lnl7/nix-darwin/master";
    };
    home-manager-darwin = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "darwin";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    {
      darwinConfigurations = {
        "FIN-0309-Peter-Zernia" = inputs.darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/m1
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

