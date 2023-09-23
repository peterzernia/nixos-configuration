{
  users.groups.media = {};
  users.users.radarr.extraGroups = [ "media" ];
  users.users.sonarr.extraGroups = [ "media" ];

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
    prowlarr = {
      enable = true;
    };
    deluge = {
      enable = true;
      user = "peter";
      group = "media";
      web.enable = true;
      dataDir = "/media/torrents";
      config = {
        enabled_plugins = [ "Label" "WebUi" ];
        outgoing_interface = "wg-mullvad";
      };
    };
  };	
}

