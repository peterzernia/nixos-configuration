{ pkgs, ... }:

{
  networking = {
    wg-quick = {
      interfaces = {
        wg0 = {
          configFile = "/home/peter/nixos/NL-409.conf";
          autostart = true;
        };
      };
    };
  };
  # https://github.com/NixOS/nixpkgs/issues/228055#issuecomment-1839337654
  system.activationScripts = {
    fix-wireguard-activation = ''
      ${pkgs.iproute2}/bin/ip link del wg0
     '';
  };
}
