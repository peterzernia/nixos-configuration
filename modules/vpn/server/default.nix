{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 51820 ];
  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces = {
    wg0 = {
      listenPort = 51820;

      privateKeyFile = "/etc/wireguard/privatekey";

      peers = [
        {
          # pixel
          publicKey = "mOzQewwzqLDvfiVjkCiboWfdvzjT9cw0O4O4NvbPQVc=";
          allowedIPs = [ "10.0.0.2/32" ];
        }
        {
          # m1
          publicKey = "pm/MJIAAKF/29PBMhtTdOPC4eHp37+gMF45R3SVrSgQ=";
          allowedIPs = [ "10.0.0.3/32" ];
        }
      ];
    };
  };

  # set up NAT for internet access  
  networking.nat = {
    enable = true;
    externalInterface = "end0";
    internalInterfaces = [ "wg0" ];
  };

  # handle DNS resolution
  systemd.services.systemd-resolved.enable = true;
}
