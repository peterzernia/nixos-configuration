{
  imports =
    [
      ./hardware.nix

      ../../modules/common
      ../../modules/user
    ];

  desktopEnv.enable = true;
  hostname = "macbookpro";
}

