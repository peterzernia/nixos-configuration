{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/user

      inputs.home-manager.nixosModules.default
    ];

  user = "peter";
  desktopEnv.enable = false;

  home-manager.users.${config.user} = { pkgs, ... }: {
    home.stateVersion = "23.11";

    programs.ghostty.enable = true;
  };

}
