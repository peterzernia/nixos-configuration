{ pkgs, config, ... }:

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
  services.displayManager.autoLogin.user = "${config.user}";

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

  services.ollama = {
    enable = true;
    # acceleration = "cuda";
    openFirewall = true;
    loadModels = [ "DeepSeek-R1" "DeepSeek-Coder-V2" ];
  };

  services.open-webui = {
    enable = true;
    openFirewall = true;
    port = 8081;
    host = "0.0.0.0";
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
    };
  };

  system.stateVersion = "24.05";
}
