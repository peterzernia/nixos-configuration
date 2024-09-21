{ config, pkgs, lib, ... }:

{
  imports = 
  [
    ./boot.nix
    ./hardware.nix

    ../../modules/common
    ../../modules/networking
    ../../modules/user
  ];


  desktopEnv.enable = false;
  hostname = "pi";
}
