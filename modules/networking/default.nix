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
      hostName = config.hostname;
      nameservers = [ "9.9.9.9" ];
    };
  };
}

