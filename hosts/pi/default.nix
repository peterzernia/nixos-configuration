{ ... }:

{
  imports =
    [
      ./boot.nix
      ./hardware.nix

      ../../modules/common
      ../../modules/networking
      ../../modules/user
      ../../modules/vpn/server
    ];

  hostname = "pi";

  services.tt-rss = {
    enable = true;
    selfUrlPath = "http://192.168.178.64";
  };

  networking.firewall.allowedTCPPorts = [ 80 ];

  system.stateVersion = "24";
}
