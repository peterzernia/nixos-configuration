{
  imports =
    [
      ./boot.nix
      ./gaming.nix
      ./hardware.nix

      ../../modules/common
      ../../modules/media
      ../../modules/user
    ];

  desktopEnv.enable = true;

  hardware.opengl.driSupport32Bit = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
