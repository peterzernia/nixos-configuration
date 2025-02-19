{ pkgs, ... }:

{
  imports =
    [
      ./boot.nix
      ./hardware.nix
      ./home.nix

      ../../modules/common
      ../../modules/gaming
      ../../modules/media
      ../../modules/networking
      ../../modules/user
      ../../modules/vpn/client
    ];

  desktopEnv.enable = true;
  devEnv.enable = true;
  homeNetwork.enable = true;
  hostname = "nixos";
  nvidia.enable = true;
  services.syncthing.enable = true;

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "peter";

  networking = {
    firewall = {
      allowedTCPPorts = [
        8384 # syncthing
      ];
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  systemd.services.hd-idle = {
    description = "External HD spin down daemon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # Type = "forking";
      ExecStart = "${pkgs.hd-idle}/bin/hd-idle -i 0 -a sda -i 300 -a sdc -i 300";
      User = "root";
      Environment = "SYSTEMD_LOG_LEVEL=debug";
    };
  };

  system.stateVersion = "24.05";
}
