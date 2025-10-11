{ config, pkgs, lib, bulitins, ... }:

{
  imports = 
  [
    ./editor.nix
  ];

  options = {
    desktopEnv.enable = lib.mkEnableOption "enable desktop environment";
  };

  config = lib.mkIf config.desktopEnv.enable {
    home-manager.users.${config.user} = { pkgs, config, ... }: {
      home.packages = with pkgs; [
        firefox
        libreoffice
        kdePackages.dolphin
        networkmanagerapplet
        pavucontrol
        powertop
        rclone
        rofi
        spotify
        unzip
        unrar
        vlc

        egl-wayland
        hypridle
        hyprlock
        swaybg
        wayland-utils
      ];

      programs.ghostty = {
        enable = true;
      };
      
      home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

      wayland.windowManager.hyprland = {
        enable = true;
        package = pkgs.hyprland;
        systemd.enable = true;
        xwayland.enable = true;
        settings = {
          "$mod" = "ALT";
          "exec-once" = [
            "waybar"
          ];
          exec = [
            "swaybg -i ~/nixos/wallpaper.jpg &"
          ];
          workspace = [
            "1, default:true"
            "2"
            "3"
            "4"
            "5"
            "6"
            "7"
            "8"
            "9"
            "10"
          ];
          bind = [
            "$mod, e, exec, rofi -show run"
            "$mod, Return, exec, ghostty"
            "$mod SHIFT, apostrophe, killactive"

            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 10"

            "$mod SHIFT, 1, movetoworkspace, 1"
            "$mod SHIFT, 2, movetoworkspace, 2"
            "$mod SHIFT, 3, movetoworkspace, 3"
            "$mod SHIFT, 4, movetoworkspace, 4"
            "$mod SHIFT, 5, movetoworkspace, 5"
            "$mod SHIFT, 6, movetoworkspace, 6"
            "$mod SHIFT, 7, movetoworkspace, 7"
            "$mod SHIFT, 8, movetoworkspace, 8"
            "$mod SHIFT, 9, movetoworkspace, 9"
            "$mod SHIFT, 0, movetoworkspace, 10"
          ];
          env = [
            "LIBVA_DRIVER_NAME,nvidia"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          ];
          input = {
            kb_layout = "us,us";
            kb_variant = "dvorak,";
            kb_options = "grp:win_space_toggle";
          };
          animations.enabled = false;
          decoration = {
            rounding = 10;
          };
          general = {
            gaps_in = 5;  
            gaps_out = 6;
          };
        };
      };

      programs.waybar = {
        enable = true;
        style = builtins.readFile ../../dotfiles/waybar/style.css;
        settings = [{
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-right = [
            "custom/ip"
            "custom/divider"
            "pulseaudio"
            "custom/divider"
            "tray"
            "custom/divider"
            "clock"
          ];
          "hyprland/workspaces" = {
            disable-scroll = false;
          };
          pulseaudio = {
            format = "{icon}  {volume}%";
            tooltip = false;
            format-muted = " Muted";
            on-click = "pavucontrol";
            scroll-step = 5;
            format-icons = {
              default = [ "" "" "" ];
            };
          };
          tray = {
            spacing = 8;
          };
          "custom/divider" = {
            format = " | ";
            interval = "once";
            tooltip = false;
          };
          "custom/ip" = {
            exec = "ip=$(curl ifconfig.me);echo $ip";
            interval = 300;
            format = "{}";
          };
        }];
      };

      services.hypridle = {
        enable = true;
        settings = {
          listener = [
            # {
            #   timeout = 300;
            #   on-timeout = "hyprlock";
            # }
            {
              timeout = 330;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };
      };

      # xdg.configFile.i3 = {
      #   recursive = true;
      #   source = ../../dotfiles/i3;
      # };
      # xdg.configFile.i3blocks = {
      #   recursive = true;
      #   source = ../../dotfiles/i3blocks;
      # };
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
      nerd-fonts.droid-sans-mono
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

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --user-menu --cmd Hyprland";
        };
      };
    };

    # services = {
    #   displayManager = {
    #     defaultSession = "xfce+i3";
    #   };
    #
    #   xserver = {
    #     enable = true;
    #     xkb.layout = "us";
    #     xkb.variant = "dvorak";
    #
    #     desktopManager = {
    #       xterm.enable = false;
    #       xfce = {
    #         enable = true;
    #         noDesktop = true;
    #         enableXfwm = false;
    #       };
    #     };
    #
    #     windowManager = {
    #       i3 = {
    #         enable = true;
    #         extraPackages = with pkgs; [
    #           i3status
    #           i3lock
    #           i3blocks
    #           rofi
    #         ];
    #       };
    #     };
    #   };
    # };
    #
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

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
