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
    services.resolved.enable = true;

    networking = {
      networkmanager.enable = true;
      networkmanager.insertNameservers = [ "9.9.9.9" ];
      hostName = config.hostname;
      enableIPv6 = false;
      wg-quick = {
        interfaces = {
          wg0 = {
            configFile = "/home/peter/sync/notes/nixos-NL-409.conf";
            autostart = true;
          };
        };
      };
    };
  };
}

