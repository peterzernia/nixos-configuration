{
  imports =
    [
      ../../modules/common
      ../../modules/user
    ];

    desktopEnv.enable = false;

    networking = {
      hostName = "pi";
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

