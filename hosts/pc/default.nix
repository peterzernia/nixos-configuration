{ pkgs, ... }:

{
  imports =
    [
      ./boot.nix
      ./hardware.nix

      ../../modules/common
      ../../modules/gaming
      ../../modules/media
      ../../modules/networking
      ../../modules/user
      ../../modules/vpn/client
    ];

  desktopEnv.enable = true;
  devEnv.enable = true;
  homeNetwork.enable = true;
  hostname = "nixos";
  nvidia.enable = true;
  services.syncthing.enable = true;

  networking = {
    firewall = {
      allowedTCPPorts = [
        8384 # syncthing
      ];
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.udev.packages = with pkgs; [
    android-udev-rules
  ];
}
