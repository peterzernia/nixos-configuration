# nixos-configuration

## modules

### common

### gaming
The gaming module assumes you have a drive mounted at /games.
`nvidia.enable = true;` enables support for nvidia graphics cards.

### media
The media module assumes you have a drive mounted at /media.

### networking
Hostname should be set with `hostname = "nixos";`.
If the machine is running in the home network, setting
`homeNetwork.enable = true;`

### user
The user module is broken up into the basic default user config 
I would want on most machines with fish, tmux, vim, etc. A desktop
environment with xfce+i3 can be enabled by adding
`desktopEnv.enable = true;`

## Steps
1. Install NixOS on any machine and then clone these files into ~/nixos
2. Run `sudo nixos-rebuild switch --flake ~/nixos#<host>`

