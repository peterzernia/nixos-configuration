{
  networking = {
    hostName = "nixos";
    firewall = {
      allowedTCPPorts = [
        22
      ];
    };
    extraHosts = ''
      192.168.178.24 nextcloud.peterzernia.com
    '';
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "22.11";
}
