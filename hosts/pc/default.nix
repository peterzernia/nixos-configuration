{
  imports =
    [
      ./boot.nix
      ./gaming.nix
      ./hardware.nix
      ./media.nix

      ../../modules/user/desktop.nix
      ../../modules/user/home.nix
    ];

  hardware.opengl.driSupport32Bit = true;

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
