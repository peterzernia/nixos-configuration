{ config, lib, ... }:

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
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
    };
    environment.variables.EDITOR = "nvim";

    home-manager.users.${config.user} = { pkgs, ... }: {
      home.packages = with pkgs; [
        bat
        bind
        cargo # nil_ls
        gcc
        git
        htop
        nixpkgs-fmt
        nodejs # astronvim ls, formatters, etc
        rustc
        ripgrep # text search in nvim
        yarn
      ];

      programs.atuin = {
        enable = true;
        settings = {
          filter_mode = "global";
          filter_mode_shell_up_key_binding = "session";
          keymap_mode = "vim-normal";
          enter_accept = true;
        };
      };

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
