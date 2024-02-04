{ config, lib, ... }:

# https://nixos.wiki/wiki/Nvidia

{
  options = {
    nvidia.enable = lib.mkEnableOption "enable nvidia graphics card";
  };

  config = lib.mkIf config.nvidia.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
