{ config, lib, ... }:

{
  options = {
    homeNetwork.enable = lib.mkEnableOption "enable home network settings";
  };

  config = lib.mkIf config.homeNetwork.enable {
    networking = {
      firewall = {
        allowedTCPPorts = [
          22
        ];
      };
      extraHosts = ''
      '';
    };
  };
}

