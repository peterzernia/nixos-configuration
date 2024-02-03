{
  imports =
    [
      ./boot.nix
      ./gaming.nix
      ./hardware.nix
      ./media.nix

      ../../modules/common
      ../../modules/user
    ];

  desktopEnv.enable = true;

  hardware.opengl.driSupport32Bit = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
