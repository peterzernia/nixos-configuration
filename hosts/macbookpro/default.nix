{
  imports =
    [
      ./hardware.nix

      ../../modules/common
      ../../modules/networking
      ../../modules/user
    ];

  desktopEnv.enable = true;
  hostname = "macbookpro";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}

