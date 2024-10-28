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
        nixpkgs-fmt
        powertop
        rclone
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
        themeFile = "Catppuccin-Macchiato";
      };

      xdg.configFile.i3 = {
        recursive = true;
        source = ../../dotfiles/i3;
      };
      xdg.configFile.i3blocks = {
        recursive = true;
        source = ../../dotfiles/i3blocks;
      };
      xdg.configFile.rclone = {
        recursive = true;
        source = ../../dotfiles/rclone;
      };
    };

    users.users.peter = {
      packages = with pkgs; [
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

    services = {
      displayManager = {
        defaultSession = "xfce+i3";
      };

      xserver = {
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
    };

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

    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
