{ pkgs, ... }:

{
  users.groups.media = { };
  users.users.peter.extraGroups = [ "media" ];
  users.users.sonarr.extraGroups = [ "media" ];
  users.users.radarr.extraGroups = [ "media" ];
  users.users.bazarr.extraGroups = [ "media" ];

  systemd.tmpfiles.rules = [
    "d /media 0770 - media - -"
  ];

  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    sonarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    bazarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    deluge = {
      enable = true;
      user = "peter";
      group = "media";
      web.enable = true;
      dataDir = "/media/torrents";
      declarative = true;
      config = {
        download_location = "/media/torrents";
        enabled_plugins = [ "Label" ];
        outgoing_interface = "wg0-mullvad";
        stop_seed_at_ratio = false;
        max_active_downloading = 1000;
        max_active_seeding = 1000;
        max_active_limit = 2000;
      };
      authFile = pkgs.writeTextFile {
        name = "deluge-auth";
        text = ''
          localclient::10
        '';
      };
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [
        6767 # bazarr
        7878 # radarr
        8112 # deluge
        8989 # sonarr
      ];
    };
  };
}

