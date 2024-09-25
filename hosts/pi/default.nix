{ ... }:

{
  imports =
    [
      ./boot.nix
      ./hardware.nix

      ../../modules/common
      ../../modules/networking
      ../../modules/vpn/server
      ../../modules/user
    ];


  desktopEnv.enable = false;
  hostname = "pi";

  services.tt-rss = {
    enable = true;
    selfUrlPath = "http://192.168.178.64";
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
