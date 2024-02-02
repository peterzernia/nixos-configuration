{ config, pkgs, ... }:

let
  home = "/home/peter";
  dotfiles = "/etc/nixos/dotfiles";
in

{
  imports = [ <home-manager/nixos> ];

  users.defaultUserShell = pkgs.fish;
  environment.variables.EDITOR = "nvim";

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

  home-manager.useGlobalPkgs = true;
}

