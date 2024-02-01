{ config, pkgs, ... }:

let
  home = "/home/peter";
  dotfiles = "/etc/nixos/dotfiles";
in

{
  imports = [ <home-manager/nixos> ];

  users.defaultUserShell = pkgs.fish;
  environment.variables.EDITOR = "nvim";

  users.users.peter = {
    isNormalUser = true;
    description = "Peter";
    extraGroups = [ "networkmanager" "wheel" "media" ];
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGvDG+MlgB0jKXNGqIcRFMbHbOI7j5SL8BFoMI7IkTt/JRGND9VpZF0gm6mvUs/7XRw7nlkfzBgRORUmo+ECioRQTLYGKnbsO7qOwNMK1vn/uEN0Fm8aYV9ZmFJ8rA8KruMk13iHQ4mxfSel5+l3UGM0FNCoYP1KH3sGVhlIbSgSvDFOtxdtSyIaPGWi8V14bo/FA+cHjczCEi9QtQoxQI623SoXT33TrZexscBM2sMjWVoPvhPHAY3jNzh9/kUxCl7wh+5YSKRd1fa+c/GYX59UETYhL903miId+i1VsI0lPQ0mhwJl6XpwzmGZJTjoDiTasyIJxGVRKOB1g47bdk27FaCYLP2+b/IfN4Zh+YRQ+fvMoQ53b5PsJLfj3Zfo9fzqcji77EUHoa0lMgzw0Z0zhgMA9GjslBx4Qijs4xKkROFrh1XBBjwqMHzG+boxMXRE6go1JVa2tpMEfrrSh0rd7A6oh6CiyRSyfBt6svlSkjgQhLv9TslRRqFY7nQRk= peterzernia@FIN-0309-Peter-Zernia.fritz.box"];
    packages = with pkgs; [
      feh
      ffmpeg
      firefox
      libreoffice
      mullvad-vpn
      nextcloud-client
      soulseekqt
      spotify
      syncthing
      vlc
    ];
  };

  home-manager.users.peter = { pkgs, ... }: {
    home.packages = with pkgs; [
      tmux
    ];

    programs.fish.enable = true;
    programs.neovim = {
      enable = true;
    };

    programs.kitty = {
      enable = true;
      font = {
        name = "DroidSansMono Nerd Font Mono";
        size = 10;
      };
      theme = "Catppuccin-Macchiato";
    };

    home.activation.config = ''
      ln -sf ${dotfiles}/fish ${home}/.config/fish
      ln -sf ${dotfiles}/i3 ${home}/.config/i3
      ln -sf ${dotfiles}/i3blocks ${home}/.config/i3blocks
      ln -sf ${dotfiles}/nvim ${home}/.config/nvim
      ln -sf ${dotfiles}/tmux ${home}/.config/tmux
    '';

    home.stateVersion = "22.11";
  };

  security.sudo.extraRules= [
    {  users = [ "peter" ];
      commands = [
        { command = "ALL" ;
           options= [ "NOPASSWD" ];
        }
      ];
    }
  ];

  services = {
    syncthing = {
        enable = true;
        user = "peter";
        dataDir = "/home/peter/Sync";
        configDir = "/home/peter/Sync/.config";
    };
    mullvad-vpn = {
      enable = true;
    };
    openssh = {
      enable = true;
    };
  };

  home-manager.useGlobalPkgs = true;
}

