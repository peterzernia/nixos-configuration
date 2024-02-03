{ config, pkgs, inputs, ... }:

let
  vars = import ../../config/variables.nix;
in

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
      git
      gparted
      lsof
      nodejs
      tmux
      rustc
      yarn
    ];

    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
    };

    home.activation.config = ''
      ln -sf ${vars.dotfilesDir}/fish ${vars.homeDir}/.config/fish
      ln -sf ${vars.dotfilesDir}/i3 ${vars.homeDir}/.config/i3
      ln -sf ${vars.dotfilesDir}/i3blocks ${vars.homeDir}/.config/i3blocks
      ln -sf ${vars.dotfilesDir}/nvim ${vars.homeDir}/.config/nvim
      ln -sf ${vars.dotfilesDir}/tmux ${vars.homeDir}/.config/tmux
    '';

    home.stateVersion = "22.11";
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "DroidSansMono" ]; })
  ];

  services = {
    syncthing = {
      enable = true;
      user = "peter";
      dataDir = "${vars.homeDir}/Sync";
      configDir = "${vars.homeDir}/Sync/.config";
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

