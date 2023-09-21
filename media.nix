{
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = { enable = true; };
  };	

  system.userActivationScripts = {
    multimediaSetup = {
      text = ''
        /run/current-system/sw/bin/setfacl -m u:jellyfin:rx ~/ 
        /run/current-system/sw/bin/setfacl -m u:sonarr:rx ~/ 
        /run/current-system/sw/bin/setfacl -m u:sonarr:rwx ~/media/shows 
      '';
      deps = [];
    };
  };
}

