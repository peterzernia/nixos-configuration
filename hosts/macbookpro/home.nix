{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/user

      inputs.home-manager.nixosModules.default
    ];

  user = "peter";
  desktopEnv.enable = true;

  home-manager.users.${config.user} = { pkgs, ... }: {
    home.stateVersion = "23.11";
  };
}
