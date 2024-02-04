{
  imports =
    [
      ./nvidia.nix
    ];

  systemd.tmpfiles.rules = [
   "d /games 0770 peter - - -"
  ];

  home-manager.users.peter = { pkgs, ... }: {
    home.packages = with pkgs; [
      discord
      heroic
      mangohud
      sc-controller
      steam
    ];
  };

  programs.gamemode.enable = true;
}
