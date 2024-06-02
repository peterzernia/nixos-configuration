{ config, lib, ... }:

{
  options = {
    devEnv.enable = lib.mkEnableOption "enable developer tools";
  };

  config = lib.mkIf config.devEnv.enable {
    home-manager.users.peter = { pkgs, ... }: {
      home.packages = with pkgs; [
        # awscli
        docker-compose
        go
        kubectl
        kubectx
        k9s
        mycli
        pgcli
        python3
      ];
    };

    users.extraUsers.peter.extraGroups = [ "docker" ];
    virtualisation.docker = {
      enable = true;
      storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}

