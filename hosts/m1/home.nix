{ config, inputs, pkgs, ... }:

{
  imports =
    [
      ../../modules/user/editor.nix
      ../../modules/user/home.nix

      inputs.home-manager-darwin.darwinModules.default
    ];

  user = "peterzernia";
  # programs.fish = {
  #   enable = true;
  #   interactiveShellInit = ''
  #     fish_vi_key_bindings
  #   '';
  # };

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
      k9s
      kubectx
      kind
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
      darktable
      discord
      # firefox
      iterm2
    ];

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
