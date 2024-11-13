{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/pc
            inputs.home-manager.nixosModules.default
          ];
        };
        macbookpro = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/macbookpro
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

