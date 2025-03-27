# heim
[![Built with Nix](https://img.shields.io/badge/Built%20with%20Nix%20and%20%E2%9D%A4%EF%B8%8F-5277C3?logo=nixos&logoColor=FFFFFF)](https://builtwithnix.org/)
[![Lint workflow](https://github.com/zacharyarnaise/heim/actions/workflows/lint.yml/badge.svg)](https://github.com/zacharyarnaise/heim/actions/workflows/lint.yml)

*Wie d'Heim* — An [Alsatian](https://en.wikipedia.org/wiki/Alsace) phrase meaning "being at home"

## Overview
This repository holds configuration files for my personal systems that runs on NixOS.

> [!Important]
> I am by no means an expert on Nix or NixOS. Whatever you do with this,
> keep in mind that mistakes will be made and things might break.

## Repository structure
```sh
.
├── home    # Home-manager configuration
├── hosts
└── modules # NixOS modules
```

## Bootstrapping a new host
### On the target host
1. Get the latest NixOS minimal ISO from [here](https://nixos.org/download.html#nixos-iso)
2. Follow [these instructions](https://nixos.org/manual/nixos/stable/index.html#sec-booting-from-usb) to create a bootable USB drive
3. Boot the installer, [set the keyboard layout and connect to the internet](https://nixos.org/manual/nixos/stable/#sec-installation-manual)
4. Set root password to allow SSH access
### On an existing NixOS system
1. Declare the new host in this repository
2. Generate an SSH key pair that will be used as the host key, use it to encrypt the host's secrets.<br>
   The key will be copied and must be in a structure and permissioned as it should be on the target:
    ```sh
    temp=$(mktemp -d) # Don't forget to clean it up afterwards
    install -d -m755 "$temp/persist/etc/ssh"
    ssh-keygen -t ed25519 -N "" -C "<hostname>" -f "$temp/persist/etc/ssh/ssh_host_ed25519_key"
    ```
3. Install with [`nixos-anywhere`](https://github.com/nix-community/nixos-anywhere):
    ```
    nix run github:nix-community/nixos-anywhere#nixos-anywhere --extra-files "$temp" -- --flake /home/mydir/heim#hostname --target-host root@foobar
    ```

## References / Useful resources
- Resources from the official Nix website:
  - [Learn Nix](https://nixos.org/learn.html)
  - [Nix ecosystem documentation](https://nix.dev/)
  - [NixOS reference manual](https://nixos.org/manual/nixos/unstable/)
  - [Nix Pills](https://nixos.org/guides/nix-pills/) a series of blog posts that provide an introduction to Nix

- [NixOS & Flakes book](https://nixos-and-flakes.thiscute.world/)
- [How to learn Nix](https://ianthehenry.com/posts/how-to-learn-nix/) another series of blog posts, quite dense but nonetheless useful
- [Flakes introduction](https://www.tweag.io/blog/2020-05-25-flakes/) blog posts about Nix Flakes
- [Awesome Nix](https://github.com/nix-community/awesome-nix) a curated list of Nix resources
- [Nix Starter Config](https://github.com/Misterio77/nix-starter-configs)
- hlissner's [dotfiles](https://github.com/hlissner/dotfiles)
- [EmergentMind nix-config](https://github.com/EmergentMind/nix-config)
