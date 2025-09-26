{ config, pkgs, ... }:

{
  # sonarr
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "dotnet-sdk-6.0.428"
  ];

  users.groups.media = { };
  # users.users.${config.user}.extraGroups = [ "media" ];
  users.users.navidrome.extraGroups = [ "media" ];
  users.users.sonarr.extraGroups = [ "media" ];
  users.users.radarr.extraGroups = [ "media" ];
  users.users.bazarr.extraGroups = [ "media" ];

  systemd.tmpfiles.rules = [
    "d /media 0770 - media - -"
    "d /media2 0770 - media - -"
    "d /media3 0770 - media - -"
  ];

  services = {
    navidrome = {
      enable = true;
      openFirewall = true;
      group = "media";
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        MusicFolder = "/media3/redacted";
        EnableSharing = true;
      };
    };
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
      user = "${config.user}";
      group = "media";
      web.enable = true;
      dataDir = "/media/torrents";
      declarative = true;
      config = {
        download_location = "/media/torrents";
        enabled_plugins = [ "Label"  "ltconfig" "AutoAdd" ];
        outgoing_interface = "wg0";
        incoming_interface = "wg0";
        random_port = true;
        # random_port = false;
        # listen_ports = [ ];
        upnp = false;
        natpmp = false;
        stop_seed_at_ratio = false;
        max_download_speed = 10240;
        max_active_downloading = 3;
        max_active_seeding = 10000;
        max_active_limit = 10003;
        max_upload_slots_global = -1;
        max_connections_global = -1;
      };
      authFile = pkgs.writeTextFile {
        name = "deluge-auth";
        text = ''
          localclient::10
        '';
      };
    };
    slskd = {
      enable = true;
      user = "${config.user}";
      group = "media";
      openFirewall = true;
      domain = "0.0.0.0";
      environmentFile = /home/${config.user}/slskd.env;
      settings = {
        directories = {
          downloads = "/media/soulseek/downloads";
          incomplete = "/media/soulseek/incomplete";
        };
        shares.directories = [
          "/media/soulseek"
          "/media/uploads"
        ];
      };
    };
    grafana = {
      enable = true;
      settings = {
        server = {
        http_port = 3001;
        http_addr = "0.0.0.0";
        };
      };
    };
    prometheus = {
      enable = true;
      retentionTime = "30d";
      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
        };
      };
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
        8112 # deluge-web
        8080 # qbittorrent webui
        5030 # slskd
        8989 # sonarr
        9090 # prometheus
      ];
      allowedUDPPorts = [
      ];
    };
  };

  users.users.${config.user} = {
    packages = with pkgs; [
      libnatpmp
      qbittorrent
      qbittorrent-nox
    ];
  };

  # home-manager.users.${config.user} = { pkgs, ... }: {
  #   home.file.qBittorrent = {
  #     source = ../../dotfiles/qBittorrent/qBittorrent.conf;
  #     target = ".config/qBittorrent/qBittorrent.conf";
  #   };
  # };
}

