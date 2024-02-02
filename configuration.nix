{ config, pkgs, ... }:

{
  imports =
    [
      ./pc
    ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "22.11";
}
