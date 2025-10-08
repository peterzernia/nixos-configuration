{ lib, ... }:

{
  imports =
    [
      ./home.nix

      ../../modules/common
    ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  system.stateVersion = 5;
}
