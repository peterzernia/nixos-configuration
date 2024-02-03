{ config, pkgs, lib, ... }:

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
        192.168.178.24 nextcloud.peterzernia.com
      '';
    };
  };
}

