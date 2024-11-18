{ inputs, lib, pkgs, ... }:

{
  imports =
    [
      ./home.nix

      ../../modules/common
    ];

  user = "peterzernia";

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  system.stateVersion = 5;
}
