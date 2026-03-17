{ config, inputs, pkgs, ... }:

{
  imports =
    [
      ../../modules/user/editor.nix
      ../../modules/user/home.nix

      inputs.home-manager-darwin.darwinModules.default
    ];

  # needed for homebrew
  system.primaryUser = "peterzernia";
  user = "peterzernia";

  users.users.${config.user} = {
    home = /Users/${config.user};
    shell = pkgs.fish;
  };

  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "ghostty"
      "libreoffice"
      "microsoft-teams"
      "proton-drive"
      "protonvpn"
      "scroll-reverser"
      "tunnelblick"
      "vlc"
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
  };

  home-manager.users.${config.user} = { pkgs, ... }: {
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
      # cli
      awscli2
      buf
      k9s
      kubectl
      kubectx
      kind
      litecli
      mariadb
      mirrord
      mycli
      pgcli
      postgresql
      protobuf
      protoc-gen-go
      protoc-go-inject-tag
      skhd
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
      # poetry
      python313
      oapi-codegen
      ruff
      typescript-language-server
      uv

      # apps
      codex
      firefox-devedition
      # google-chrome
      insomnia
      raycast
      spotify
    ];

    xdg.configFile.skhd = {
      recursive = true;
      source = ../../dotfiles/skhd;
    };
    xdg.configFile.yabai = {
      recursive = true;
      source = ../../dotfiles/yabai;
    };

    services.syncthing.enable = true;
  };
}
