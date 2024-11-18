{ inputs, lib, pkgs, ... }:

{
  imports =
    [
      inputs.home-manager.darwinModules.default
    ];

  programs.fish.enable = true;

  users.users.peterzernia = {
    home = /Users/peterzernia;
    shell = pkgs.fish;
  };

  home-manager.users.peterzernia = { pkgs, ... }: {
    home.packages = with pkgs; [
      bat
      cargo # nil_ls
    ];

    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
    };

    programs.tmux = {
      enable = true;
      plugins = with pkgs; [
        tmuxPlugins.continuum
        tmuxPlugins.resurrect
        tmuxPlugins.sensible
      ];
    };

    xdg.configFile.fish = {
      recursive = true;
      source = ../../dotfiles/fish;
    };
    xdg.configFile.nvim = {
      recursive = true;
      source = ../../dotfiles/nvim;
    };
    home.file.tmux = {
      source = ../../dotfiles/tmux/.tmux.conf;
      target = ".tmux.conf";
    };

    home.stateVersion = "24.11";
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  system.stateVersion = 5;
}
