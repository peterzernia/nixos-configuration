# nixos-configuration

## Creating new host 
1. Create new directory in hosts with desired config
2. Create new entry in nixConfigurations in flake.nix
3. Install NixOS on new machine
4. Close these files into ~/nixos
5. Copy hardware configuration into hosts/<host>
6. Add boot loader config to the new host
    basic config:
    ```
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    ```
7. `git add .` may be needed to make new files available to nix store
8. Run `sudo nixos-rebuild switch --flake ~/nixos#<host>`

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
The media module assumes you have a drive mounted at:
/media
/media2
/media3

### networking
Hostname should be set with `hostname = "nixos";`.
If the machine is running in the home network, setting
`homeNetwork.enable = true;`

### user
The user module is broken up into the basic default user config 
I would want on most machines with fish, tmux, vim, etc. The home.nix
can be imported directly, for example, in a darwin setup or the user
module can be imported completely on a nixos setup.

A desktop environment with xfce+i3 can be enabled by adding
`desktopEnv.enable = true;`
Developer environment can be setup with `devEnv.enable = true;`


### vpn
Both client and server vpn confings exist here.

## packages
### nvim
nvim is using [AstroNvim](https://astronvim.com/). On the first run,
all of the dependencies will be installed. Language servers, linters,
formatters, etc must all be installed through AstroNvim. Ex
`:LspInstall nil_ls` will install the nixos languange server `nil`
for syntax highlighting

## problems
### dns
Setting up macbookpro for the first time, I could connect to wifi,
but no dns. I had to manually edit /etc/resolv.conf to get connected.

