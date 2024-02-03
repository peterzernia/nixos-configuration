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
    ];

  desktopEnv.enable = true;
  nvidia.enable = true;
  homeNetwork.enable = true;
  hostname = "nixos";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
