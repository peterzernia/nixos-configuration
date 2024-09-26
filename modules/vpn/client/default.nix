{ ... }:

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
}
