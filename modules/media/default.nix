{ pkgs, ... }:

{
  users.groups.media = { };
  users.users.peter.extraGroups = [ "media" ];
  users.users.sonarr.extraGroups = [ "media" ];
  users.users.radarr.extraGroups = [ "media" ];
  users.users.bazarr.extraGroups = [ "media" ];

  systemd.tmpfiles.rules = [
    "d /media 0770 - media - -"
    "d /media2 0770 - media - -"
    "d /media3 0770 - media - -"
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
      dataDir = "/media2/torrents";
      declarative = true;
      config = {
        download_location = "/media2/torrents";
        enabled_plugins = [ "Label"  "ltconfig" ];
        outgoing_interface = "wg0";
        incoming_interface = "wg0";
        stop_seed_at_ratio = false;
        max_download_speed = 10240;
        max_active_downloading = 3;
        max_active_seeding = 1000;
        max_active_limit = 1003;
        max_upload_slots = -1;
      };
      authFile = pkgs.writeTextFile {
        name = "deluge-auth";
        text = ''
          localclient::10
        '';
      };
    };
    grafana = {
      enable = true;
      settings = {
        server = {
        port = 3001;
        };
      };
    };
    prometheus = {
      enable = true;
      scrapeConfigs = [
        {
          job_name = "deluge-exporter";
          static_configs = [{
            targets = [ "0.0.0.0:8011" ];
          }];
        }
      ];
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [
        3001 # grafana
        6767 # bazarr
        7878 # radarr
        8112 # deluge
        8989 # sonarr
      ];
    };
  };

  users.users.peter = {
    packages = with pkgs; [
      libnatpmp
    ];
  };
}

