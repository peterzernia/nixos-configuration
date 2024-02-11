{ config, pkgs, lib, ... }:

{
  options = {
    desktopEnv.enable = lib.mkEnableOption "enable desktop environment";
  };

  config = lib.mkIf config.desktopEnv.enable {
    home-manager.users.peter = { pkgs, ... }: {
      home.packages = with pkgs; [
        firefox
        libreoffice
        nextcloud-client
        nixpkgs-fmt
        soulseekqt
        spotify
        unzip
        vlc
      ];

      programs.kitty = {
        enable = true;
        font = {
          name = "DroidSansMono Nerd Font Mono";
          size = 10;
        };
        theme = "Catppuccin-Macchiato";
      };

      xdg.configFile.i3 = {
        recursive = true;
        source = ../../dotfiles/i3;
      };
      xdg.configFile.i3blocks = {
        recursive = true;
        source = ../../dotfiles/i3blocks;
      };
    };

    # setting up mullvad with home-mananger caused
    # issue with settings persintance and deluge
    users.users.peter = {
      packages = with pkgs; [
        mullvad-vpn
      ];
    };

    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "DroidSansMono" ]; })
    ];

    security.sudo.extraRules = [
      {
        users = [ "peter" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];

    services.blueman.enable = true;

    console.keyMap = "dvorak";

    services.xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "dvorak";

      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };

      displayManager = {
        defaultSession = "xfce+i3";
      };

      windowManager = {
        i3 = {
          enable = true;
          extraPackages = with pkgs; [
            i3status
            i3lock
            i3blocks
            rofi
          ];
        };
      };
    };

    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # required for nextcloud client
    services.gnome.gnome-keyring.enable = true;
  };
}
