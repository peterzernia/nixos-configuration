{ config, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
   "d /games 0770 peter - - -"
  ];

  home-manager.users.peter = { pkgs, ... }: {
    home.packages = with pkgs; [
      discord
      heroic
      mangohud
      sc-controller
      steam
    ];
  };

  programs.gamemode.enable = true;

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
