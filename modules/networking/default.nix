{ config, lib, ... }:

{ 
  imports =
    [
      ./home.nix
    ];

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

