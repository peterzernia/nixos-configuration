{ config, pkgs, ... }:
{
  imports =
    [
      ./desktop.nix
      ./dev.nix
      ./home.nix
    ];

  users.defaultUserShell = pkgs.fish;
  console.keyMap = "dvorak";
  time.timeZone = "Europe/Berlin";

  users.users.${config.user} = {
    isNormalUser = true;
    description = "peter";
    extraGroups = [ "networkmanager" "wheel" "media" "video" "input" ];
    openssh.authorizedKeys.keys = [
      # m1
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGvDG+MlgB0jKXNGqIcRFMbHbOI7j5SL8BFoMI7IkTt/JRGND9VpZF0gm6mvUs/7XRw7nlkfzBgRORUmo+ECioRQTLYGKnbsO7qOwNMK1vn/uEN0Fm8aYV9ZmFJ8rA8KruMk13iHQ4mxfSel5+l3UGM0FNCoYP1KH3sGVhlIbSgSvDFOtxdtSyIaPGWi8V14bo/FA+cHjczCEi9QtQoxQI623SoXT33TrZexscBM2sMjWVoPvhPHAY3jNzh9/kUxCl7wh+5YSKRd1fa+c/GYX59UETYhL903miId+i1VsI0lPQ0mhwJl6XpwzmGZJTjoDiTasyIJxGVRKOB1g47bdk27FaCYLP2+b/IfN4Zh+YRQ+fvMoQ53b5PsJLfj3Zfo9fzqcji77EUHoa0lMgzw0Z0zhgMA9GjslBx4Qijs4xKkROFrh1XBBjwqMHzG+boxMXRE6go1JVa2tpMEfrrSh0rd7A6oh6CiyRSyfBt6svlSkjgQhLv9TslRRqFY7nQRk= peterzernia@FIN-0309-Peter-Zernia.fritz.box"
      # m3
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2qwaWgyHL8juWDNF1413f4xqoFDKy4guarLYlOoUaB peterzernia@MacBook-Pro-von-FinCompare.local"
    ];
  };

  services.cron = {
    enable = true;
  };

  services.syncthing = {
    user = "peter";
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "m3" = { id = "YAF5IQH-X7ZMGQP-VUE2ARA-XLR2Q2U-TVJJI4M-PESL44T-MJ5M3LA-JVNWUQM"; };
        "pixel7a" = { id = "TH53SNX-NGQOJWR-BY6NGIA-FEXGNG5-BHJ2UEV-MSZWPW3-SPLJEKS-IBEO3Q3"; };
        "nixos" = { id = "FYE2OFW-YBGUODS-NAMNIAM-4JGI4BJ-CAZMLE2-OGCFSDN-42WJ25H-2WHYYQZ"; };
      };
      folders = {
        "Backups" = {
          id = "68kqw-rn8e2";
          path = "/home/peter/sync/backups";
          devices = [ "m3" "pixel7a" "nixos" ];
        };
        "Notes" = {
          path = "/home/peter/sync/notes";
          devices = [ "m3" "pixel7a" "nixos" ];
        };
        "Documents" = {
          path = "/home/peter/sync/documents";
          devices = [ "m3" "pixel7a" "nixos" ];
        };
        "Soulseek" = {
          path = "/media/soulseek/downloads";
          devices = [ "m3" "nixos" ];
        };
      };
    };
  };

  services.openssh.enable = true;

}
