{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./media.nix
    ];

  hardware.opengl.driSupport32Bit = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
    };
    grub = {
      # Disable grub
      enable = false;
      version = 2;
      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = ["nodev"];
      useOSProber = true;
      configurationLimit = 5;
    };
    efi = {
      # canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  boot.supportedFilesystems = ["ntfs"];

  boot.initrd.kernelModules = ["uas" "usbcore" "usb_storage" "vfat" "nls_cp437" "nls_iso8859_1"];
  boot.kernelParams = [ "quiet" "splash" ];

  # Enable swap on luks
  boot.initrd.luks.devices = {
    "luks-c44ed61b-7f86-40fa-88d2-2edb8754264c" = {
      device = "/dev/disk/by-uuid/c44ed61b-7f86-40fa-88d2-2edb8754264c";
      allowDiscards = true;
      keyFileSize = 4096;
      keyFile = "/dev/sde";
      fallbackToPassword = true;
      preLVM = false;
    };
    "luks-8d8d5986-edf8-4ed7-acb9-74915f1f079f" = {
      device = "/dev/disk/by-uuid/8d8d5986-edf8-4ed7-acb9-74915f1f079f";
      allowDiscards = true;
      keyFileSize = 4096;
      keyFile = "/dev/sde";
      fallbackToPassword = true;
      preLVM = false;
    };
  };

  networking = {
    hostName = "nixos";
    firewall = {
      allowedTCPPorts = [
        22
        8080 # qbittorrent webui
      ];
    };
    extraHosts = ''
      192.168.178.24 nextcloud.peterzernia.com
    '';
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "dvorak";

    desktopManager = {
      xterm.enable = true;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    displayManager = {
      defaultSession = "xfce+i3";
    };

    windowManager = {
      i3 = {
        enable = true;
        extraPackages = with pkgs; [
          rofi
          i3status
          i3lock
          i3blocks
        ];
      };
    };
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.fish.enable = true;
  environment.variables.EDITOR = "nvim";

  # Keyring daemon for storing credentials. Required by NextCloud desktop client.
  services.gnome.gnome-keyring.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.peter = {
    isNormalUser = true;
    description = "Peter";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGvDG+MlgB0jKXNGqIcRFMbHbOI7j5SL8BFoMI7IkTt/JRGND9VpZF0gm6mvUs/7XRw7nlkfzBgRORUmo+ECioRQTLYGKnbsO7qOwNMK1vn/uEN0Fm8aYV9ZmFJ8rA8KruMk13iHQ4mxfSel5+l3UGM0FNCoYP1KH3sGVhlIbSgSvDFOtxdtSyIaPGWi8V14bo/FA+cHjczCEi9QtQoxQI623SoXT33TrZexscBM2sMjWVoPvhPHAY3jNzh9/kUxCl7wh+5YSKRd1fa+c/GYX59UETYhL903miId+i1VsI0lPQ0mhwJl6XpwzmGZJTjoDiTasyIJxGVRKOB1g47bdk27FaCYLP2+b/IfN4Zh+YRQ+fvMoQ53b5PsJLfj3Zfo9fzqcji77EUHoa0lMgzw0Z0zhgMA9GjslBx4Qijs4xKkROFrh1XBBjwqMHzG+boxMXRE6go1JVa2tpMEfrrSh0rd7A6oh6CiyRSyfBt6svlSkjgQhLv9TslRRqFY7nQRk= peterzernia@FIN-0309-Peter-Zernia.fritz.box"];
    shell = pkgs.fish;
    packages = with pkgs; [
      discord
      feh
      ffmpeg
      firefox
      heroic
      libreoffice
      mullvad-vpn
      nextcloud-client
      qbittorrent
      sc-controller
      soulseekqt
      spotify
      steam
      syncthing
      vlc
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dig
    git
    gparted
    nodejs
    tmux
    wget
    yarn
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "DroidSansMono" ]; })
  ];

  services = {
    syncthing = {
        enable = true;
        user = "peter";
        dataDir = "/home/peter/Sync";
        configDir = "/home/peter/Sync/.config";
    };
    mullvad-vpn = {
      enable = true;
    };
    openssh = {
      enable = true;
    };
  };

  system.stateVersion = "22.11";
}
