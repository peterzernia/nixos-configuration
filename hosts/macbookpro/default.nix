{
  imports =
    [
      ./hardware.nix
      ./home.nix

      ../../modules/common
      ../../modules/networking
      ../../modules/user
    ];

  hostname = "macbookpro";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24";
}
