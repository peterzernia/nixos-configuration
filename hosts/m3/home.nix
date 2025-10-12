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
      "calibre"
      "firefox"
      "ghostty"
      "libreoffice"
      "microsoft-teams"
      "proton-drive"
      "protonvpn"
      "rekordbox"
      "signal"
      "steam"
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
      ffmpeg
      k9s
      kubectl
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
      audacity
      darktable
      discord
      firefox-devedition
      google-chrome
      insomnia
      iterm2
      raycast
      spotify

      # tmp
      flac
      ghostscript
      gnupg
      tesseract
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
