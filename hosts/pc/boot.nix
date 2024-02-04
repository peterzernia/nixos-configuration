{
  boot.loader = {
    systemd-boot = {
      enable = true;
    };
    efi = {
      efiSysMountPoint = "/boot/efi";
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  boot.initrd.kernelModules = [ "uas" "usbcore" "usb_storage" "vfat" "nls_cp437" "nls_iso8859_1" ];
  boot.kernelParams = [ "quiet" "splash" ];

  # unlock luks drives at boot with USB or password as fallback
  boot.initrd.luks.devices = {
    "luks-c44ed61b-7f86-40fa-88d2-2edb8754264c" = {
      device = "/dev/disk/by-uuid/c44ed61b-7f86-40fa-88d2-2edb8754264c";
      allowDiscards = true;
      keyFileSize = 4096;
      keyFile = "/dev/sde";
      fallbackToPassword = true;
      preLVM = false;
    };
    "luks-8d8d5986-edf8-4ed7-acb9-74915f1f079f" = {
      device = "/dev/disk/by-uuid/8d8d5986-edf8-4ed7-acb9-74915f1f079f";
      allowDiscards = true;
      keyFileSize = 4096;
      keyFile = "/dev/sde";
      fallbackToPassword = true;
      preLVM = false;
    };
  };
}
