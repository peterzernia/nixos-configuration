{ pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home-manager.users.peter = { pkgs, ... }: {
    home.packages = with pkgs; [
      bat
      bind
      cargo # nil_ls
      gcc
      git
      htop
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
    home.stateVersion = "23.11";
  };

  home-manager.useGlobalPkgs = true;
}
