{
  imports =
    [
      ./boot.nix
      ./hardware.nix

      ../../modules/common
      ../../modules/gaming
      ../../modules/media
      ../../modules/user
    ];

  desktopEnv.enable = true;
  nvidia.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  networking = {
    hostName = "nixos";
    firewall = {
      allowedTCPPorts = [
        22
      ];
    };
    extraHosts = ''
      192.168.178.24 nextcloud.peterzernia.com
    '';
  };
}
