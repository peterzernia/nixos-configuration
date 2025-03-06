{ config, ... }:

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

  # steam controller
  hardware.steam-hardware.enable = true;
  users.groups.steam-controller = { };
  users.users.${config.user}.extraGroups = [ "steam-controller" ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", GROUP="steam-controller", MODE="0660"
    KERNEL=="hidraw*", KERNELS=="*28DE:*", GROUP="steam-controller", MODE="0660"
    KERNEL=="uinput", MODE="0660", GROUP="steam-controller", OPTIONS+="static_node=uinput"
  '';
  boot.kernelModules = [ "uinput" ];
}
