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
      networkmanager.enable = true;
      networkmanager.insertNameservers = [ "9.9.9.9" ];
      hostName = config.hostname;
    };
  };
}

