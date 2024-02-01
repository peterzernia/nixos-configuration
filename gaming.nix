{ config, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
   "d /games 0770 peter - - -"
  ];

  users.users.peter = {
    packages = with pkgs; [
      discord
      heroic
      sc-controller
      steam
    ];
  };

  programs.gamemode.enable = true;

  environment.systemPackages = [
    pkgs.mangohud
  ];

  # https://nixos.wiki/wiki/Nvidia
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
