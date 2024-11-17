{ inputs, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/common

      inputs.home-manager.darwinModules.default
    ];

  users.users.peterzernia = {
    home = /Users/peterzernia;
  };

  home-manager.users.peterzernia = { pkgs, ... }: {
    home.packages = with pkgs; [
      bat
    ];

    home.stateVersion = "24.11";
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  system.stateVersion = 5;
}
