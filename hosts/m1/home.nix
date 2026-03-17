{ config, inputs, pkgs, ... }:

{
  imports =
    [
      ../../modules/user/editor.nix
      ../../modules/user/home.nix

      inputs.home-manager-darwin.darwinModules.default
    ];

  # needed for homebrew
  system.primaryUser = "peter";
  user = "peter";

  users.users.${config.user} = {
    home = /Users/${config.user};
    shell = pkgs.fish;
  };

  homebrew = {
    enable = true;
    casks = [
      "calibre"
      "elektron-overbridge"
      "firefox"
      "ghostty"
      "libreoffice"
      "proton-drive"
      "protonvpn"
      "rekordbox"
      "scroll-reverser"
      "signal"
      "steam"
      "touchdesigner"
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
      ffmpeg
      litecli
      mycli
      pgcli
      skhd
      wireguard-tools
      yabai

      # language
      go
      python313

      # apps
      audacity
      darktable
      discord
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
