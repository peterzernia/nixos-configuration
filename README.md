# nixos-configuration

## Creating new host 
1. Create new directory in hosts with desired config
2. Create new entry in nixConfigurations in flake.nix
3. Install NixOS on new machine
4. Close these files into ~/nixos
5. Copy hardware configuration into hosts/<host>
6. `git add .` may be needed to make new files available to nix store
6. Run `sudo nixos-rebuild switch` --flake ~/nixos#<host>

## Steps to install existing host
1. Install NixOS on any machine
2. Clone these files into ~/nixos
2. Run `sudo nixos-rebuild switch --flake ~/nixos#<host>`

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

