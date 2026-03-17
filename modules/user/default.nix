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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEaVbH55CVn0Y+nRXldCa4XYejKFo1l39Sjle6XOtLu5 peter@MacBookPro.fritz.box"
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
        "m1" = { id = "CXEYIQB-FRSXDAT-5RJKL4R-ZQI7O3F-LSET64N-ODKNMK7-4UE4NBA-LHY6HQF"; };
        "m3" = { id = "YAF5IQH-X7ZMGQP-VUE2ARA-XLR2Q2U-TVJJI4M-PESL44T-MJ5M3LA-JVNWUQM"; };
        "pixel7a" = { id = "TH53SNX-NGQOJWR-BY6NGIA-FEXGNG5-BHJ2UEV-MSZWPW3-SPLJEKS-IBEO3Q3"; };
        "nixos" = { id = "FYE2OFW-YBGUODS-NAMNIAM-4JGI4BJ-CAZMLE2-OGCFSDN-42WJ25H-2WHYYQZ"; };
      };
      folders = {
        "Backups" = {
          id = "68kqw-rn8e2";
          path = "/home/peter/sync/backups";
          devices = [ "m1" "m3" "pixel7a" "nixos" ];
        };
        "Notes" = {
          path = "/home/peter/sync/notes";
          devices = [ "m1" "m3" "pixel7a" "nixos" ];
        };
        "Documents" = {
          path = "/home/peter/sync/documents";
          devices = [ "m1" "m3" "pixel7a" "nixos" ];
        };
        "Soulseek" = {
          path = "/media/soulseek/downloads";
          devices = [ "m1" "m3" "nixos" ];
        };
      };
    };
  };

  services.openssh.enable = true;

}
