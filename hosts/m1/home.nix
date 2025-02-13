{ config, inputs, pkgs, ... }:

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
      awscli2
      ffmpeg
      flac
      ghostscript
      gnupg
      kubectx
      k9s
      mariadb
      mycli
      pgcli
      postgresql
      protobuf
      protoc-gen-go
      protoc-go-inject-tag
      skhd
      tesseract
      traefik
      wireguard-tools
      yabai

      # language
      black
      gci
      go
      gofumpt
      golangci-lint
      goose
      go-mockery
      mockgen
      poetry
      python3
      oapi-codegen
      ruff
      typescript-language-server

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
