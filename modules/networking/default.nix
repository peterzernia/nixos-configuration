{ config, lib, ... }:

{ 
  imports =
    [
      ./home.nix
    ];

  networking.networkmanager.enable = true;

  options = {
    hostname = lib.mkOption {
      default = "hostname";
      description = ''
        hostname
      '';
    };
  };

  config = {
    networking = {
      hostName = config.hostname;
    };
  };
}

