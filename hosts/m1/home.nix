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
      kubectx
      k9s
      mycli
      pgcli
      protobuf
      skhd
      wireguard-tools
      yabai

      # language
      black
      go
      golangci-lint
      goose
      python3
      ruff

      # apps
      discord
      # firefox
      iterm2
    ];

    programs.kitty = {
      enable = true;
      font = {
        name = "DroidSansMono Nerd Font Mono";
        size = 12;
      };
      themeFile = "Catppuccin-Macchiato";
    };

    xdg.configFile.skhd = {
      recursive = true;
      source = ../../dotfiles/skhd;
    };
    xdg.configFile.yabai = {
      recursive = true;
      source = ../../dotfiles/yabai;
    };
  };
}
