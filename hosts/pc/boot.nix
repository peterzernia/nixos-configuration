{
  nix.gc.automatic = false;
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  boot.initrd.kernelModules = [ "uas" "usbcore" "usb_storage" "vfat" "nls_cp437" "nls_iso8859_1" ];
  boot.kernelParams = [ "quiet" "splash" "nvidia-drm.modeset=1" ];

  # unlock luks drives at boot with USB or password as fallback
  boot.initrd.luks.devices = {
    "luks-afba17fa-c951-44ef-bdc9-55639d0afddd" = {
      device = "/dev/disk/by-uuid/afba17fa-c951-44ef-bdc9-55639d0afddd";
      allowDiscards = true;
      keyFileSize = 4096;
      keyFile = "/dev/sdg";
      fallbackToPassword = true;
      preLVM = false;
    };
    "luks-cb862741-d080-4c5d-aabd-061aab9df019" = {
      device = "/dev/disk/by-uuid/cb862741-d080-4c5d-aabd-061aab9df019";
      allowDiscards = true;
      keyFileSize = 4096;
      keyFile = "/dev/sdg";
      fallbackToPassword = true;
      preLVM = false;
    };
  };
}
