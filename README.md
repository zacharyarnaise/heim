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

## Instructions
### Add a new host
1. Generate a new SSH keypair and get a corresponding AGE public key
    ```sh
    ssh-keygen -C user@hostname -t ed25519 -f hostname_host_ed25519
    echo -e "# hostname\n$(ssh-to-age -i hostname_host_ed25519 -private-key)" >>  ~/.config/sops/age/keys.txt
    ```

### Fresh Install
1. Get the latest NixOS minimal ISO from [here](https://nixos.org/download.html#nixos-iso)
2. Follow [these instructions](https://nixos.org/manual/nixos/stable/index.html#sec-booting-from-usb) to create a bootable USB drive
3. Boot the installer, [set the keyboard layout and connect to the internet](https://nixos.org/manual/nixos/stable/#sec-installation-manual)
4. Do the installation:
    - If the hosts uses [`disko`](https://github.com/nix-community/disko):
        ```sh
        nix --experimental-features "nix-command flakes" run github:nix-community/disko#disko-install -- -f github:zacharyarnaise/heim#hostname --write-efi-boot-entries --disk main /dev/<my-disk>
        ```
    - Otherwise, [partition and mount the disk manually](https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning) and run the following command:
        ```sh
        nixos-install --flake github:zacharyarnaise/heim#hostname
        ```
    - When partitioning manually and using impermanence, make sure to create a BTRFS snapshot of the root subvolume:
        ```sh
        mount -t btrfs -o subvol=/ /dev/mapper/crypted /mnt
        btrfs subvolume snapshot -r "/mnt/root" "/mnt/root-blank"
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
