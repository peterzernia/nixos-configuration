{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/user

      inputs.home-manager.nixosModules.default
    ];

  user = "peter";
  desktopEnv.enable = false;

  environment.variables = {
    TERM = "xterm-256color";
  };

  home-manager.users.${config.user} = { pkgs, ... }: {
    home.stateVersion = "23.11";
    home.packages = with pkgs; [
      kitty
    ];
  };
}
