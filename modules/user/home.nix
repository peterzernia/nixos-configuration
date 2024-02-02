{ config, pkgs, ... }:

let
  vars = import ../../config/variables.nix;
in

{
  imports = [ <home-manager/nixos> ];

  users.defaultUserShell = pkgs.fish;
  environment.variables.EDITOR = "nvim";

  home-manager.users.peter = { pkgs, ... }: {
    home.packages = with pkgs; [
      cargo
      git
      gparted
      lsof
      nodejs
      tmux
      yarn
    ];

    programs.fish.enable = true;
    programs.neovim = {
      enable = true;
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

