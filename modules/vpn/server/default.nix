{ pkgs, ... }:

{
  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.nat = {
    enable = true;
    externalInterface = "end0";
    internalInterfaces = [ "wg0" ];
  };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.1/24" ];

      listenPort = 51820;

      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o end0 -j MASQUERADE
      '';

      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o end0 -j MASQUERADE
      '';

      privateKeyFile = "/etc/wireguard/privatekey";

      peers = [
        {
          # pixel
          publicKey = "mOzQewwzqLDvfiVjkCiboWfdvzjT9cw0O4O4NvbPQVc=";
          allowedIPs = [ "10.100.0.2/32" ];
        }
        {
          # m1
          publicKey = "pm/MJIAAKF/29PBMhtTdOPC4eHp37+gMF45R3SVrSgQ=";
          allowedIPs = [ "10.100.0.3/32" ];
        }
      ];
    };
  };
}
