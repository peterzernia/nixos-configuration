{ config, lib, pkgs, inputs, isDarwin, ... }:

{
  options = {
    user = lib.mkOption {
      default = "peter";
      description = ''
        user
      '';
    };
  };

  config = {
    programs.fish.enable = true;
    environment.variables.EDITOR = "nvim";

    home-manager.users.${config.user} = { pkgs, ... }: {
      home.packages = with pkgs; [
        bat
        bind
        cargo # nil_ls
        fish
        gcc
        git
        htop
        nixpkgs-fmt
        nodejs # astronvim ls, formatters, etc
        rustc
        ripgrep # text search in nvim
        yarn
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
    };

    home-manager.useGlobalPkgs = true;
  };
}
