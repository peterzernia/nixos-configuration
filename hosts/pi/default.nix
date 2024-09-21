{ config, pkgs, lib, ... }:

{
  imports = 
  [
    ../../modules/common
    ../../modules/networking
    ../../modules/user
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  console.keyMap = "dvorak";

  desktopEnv.enable = false;
  hostname = "pi";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
