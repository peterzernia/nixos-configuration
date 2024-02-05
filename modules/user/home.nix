{ pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.variables.EDITOR = "nvim";

  users.users.peter = {
    isNormalUser = true;
    description = "Peter";
    extraGroups = [ "networkmanager" "wheel" "media" ];
    openssh.authorizedKeys.keys = [
      # m1
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGvDG+MlgB0jKXNGqIcRFMbHbOI7j5SL8BFoMI7IkTt/JRGND9VpZF0gm6mvUs/7XRw7nlkfzBgRORUmo+ECioRQTLYGKnbsO7qOwNMK1vn/uEN0Fm8aYV9ZmFJ8rA8KruMk13iHQ4mxfSel5+l3UGM0FNCoYP1KH3sGVhlIbSgSvDFOtxdtSyIaPGWi8V14bo/FA+cHjczCEi9QtQoxQI623SoXT33TrZexscBM2sMjWVoPvhPHAY3jNzh9/kUxCl7wh+5YSKRd1fa+c/GYX59UETYhL903miId+i1VsI0lPQ0mhwJl6XpwzmGZJTjoDiTasyIJxGVRKOB1g47bdk27FaCYLP2+b/IfN4Zh+YRQ+fvMoQ53b5PsJLfj3Zfo9fzqcji77EUHoa0lMgzw0Z0zhgMA9GjslBx4Qijs4xKkROFrh1XBBjwqMHzG+boxMXRE6go1JVa2tpMEfrrSh0rd7A6oh6CiyRSyfBt6svlSkjgQhLv9TslRRqFY7nQRk= peterzernia@FIN-0309-Peter-Zernia.fritz.box"
    ];
  };

  home-manager.users.peter = { pkgs, ... }: {
    home.packages = with pkgs; [
      cargo
      gcc
      git
      nodejs
      tmux
      rustc
      ripgrep
      yarn
    ];

    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
    };

    xdg.configFile.fish = {
      recursive = true;
      source = ../../dotfiles/fish;
    };
    xdg.configFile.nvim = {
      recursive = true;
      source = ../../dotfiles/nvim;
    };
    xdg.configFile.tmux = {
      recursive = true;
      source = ../../dotfiles/tmux;
    };

    home.stateVersion = "23.11";
  };

  services = {
    syncthing = {
      enable = false;
      user = "peter";
      dataDir = /home/peter/sync;
      overrideDevices = true;
      overrideFolders = true;
      openDefaultPorts = true;
      settings = {
        devices = {
          "m1" = { id = "TA3QDQ5-WA2RYR3-ZXXYR25-O2I7TE5-T2AIECT-XWDZX73-UY6UF35-SDFBVQN"; };
          "pi" = { id = "DCIGCJC-UF2VZG6-BW43FOM-SFCJD23-TLEQZTQ-EOOSSQJ-6I7QWL4-XWFAYAK"; };
          "pixel3" = { id = "LYMLJLT-RMHFUBE-V4R4B3K-TSM75QL-HAI5X7O-ATJ2DIF-36FV6GM-6KEDPQC"; };
        };
        folders = {
          "Notes" = {
            path = "/home/peter/sync/notes";
            devices = [ "m1" "pi" "pixel3" ];
          };
        };
      };
    };
  };

  # required for wg-mullvad atm
  networking.resolvconf.enable = false;
  services.mullvad-vpn.enable = true;
  services.openssh.enable = true;

  home-manager.useGlobalPkgs = true;
}

