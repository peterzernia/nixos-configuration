{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/user/home.nix

      inputs.home-manager.darwinModules.default
    ];

  user = "peterzernia";
  programs.fish.enable = true;

  users.users.${config.user} = {
    home = /Users/${config.user};
    shell = pkgs.fish;
  };

  home-manager.users.${config.user} = { pkgs, ... }: {
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
      # cli
      awscli
      ffmpeg
      k9s
      mycli
      pgcli
      wireguard-tools

      # language
      go
      golangci-lint
      python3

      # apps
      discord
      # firefox
      iterm2
    ];

  };
}
