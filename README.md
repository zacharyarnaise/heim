# ~/heim
[![Built with Nix](https://img.shields.io/badge/Built%20with%20Nix%20and%20%E2%9D%A4%EF%B8%8F-5277C3?logo=nixos&logoColor=FFFFFF)](https://builtwithnix.org/)
[![Lint workflow](https://github.com/zacharyarnaise/heim/actions/workflows/lint.yml/badge.svg)](https://github.com/zacharyarnaise/heim/actions/workflows/lint.yml)

Here you'll find [NixOS](https://nixos.org/) & [home-manager](https://github.com/nix-community/home-manager) configurations for my systems, declared as a single Nix flake.

### Notable features:
- Declarative disk partitioning ([disko](https://github.com/nix-community/disko))
- Full disk encryption
- Impermanence, ephemeral root in ramfs
- Secure Boot ([lanzaboote](https://github.com/nix-community/lanzaboote))
- Secrets provisioning using a separate private repo ([sops-nix](https://github.com/Mic92/sops-nix))
- Remote unattended bootstrapping via SSH ([nixos-anywhere](https://github.com/nix-community/nixos-anywhere))
- Carefuly crafted Wayland DE ([Hyprland](https://hyprland.org/))

## Structure
```sh
.
├─ .github/workflows/ # CI/CD for linting, flake checking and updates
├─ home/              # Home-manager configurations
├─ hosts/             # NixOS and system-wide configurations
│  ├─ common/    # Shared configurations
│  ├─ calcifer/  # Desktop  - 14700KF, 32GB RAM, RTX4080S
│  ├─ howl/      # Headless - RPi5, 4GB RAM
│  ├─ kamaji/    # Headless - Ryzen 5 5600X, 16GB RAM, 4TB SSD x2
│  ├─ laptop-gb/ # Laptop   - ThinkPad - to be deleted no longer in use
│  ├─ noface/    # Headless - QEMU guest used for debugging/testing
├─ lib/               # Nix utilities/helpers
├─ modules/           # Reusable, abstract pieces of config for home-manager, NixOS or both.
├─ overlays/          # Overrides/patches for some packages
├─ pkgs/              # Custom packages
└─ flake.nix          # Entrypoint for hosts and home-manager configs. Also exposes a devshell for manual bootstrapping tasks (nix-shell).
```

## Bootstrapping a new host
### On the target host
1. Follow [these instructions](https://nixos.org/manual/nixos/stable/index.html#sec-booting-from-usb) to boot NixOS minimal installer
2. Set a password for `root` to allow for SSH access
### On an existing NixOS machine
1. Declare the new host in this repository
2. Generate an SSH key pair that will be used as the host key, use it to encrypt the new host's secrets.<br>
   The key will be copied and must be in a structure and permissioned as it should be on the target:
    ```sh
    temp=$(mktemp -d) # Don't forget to clean it up afterwards
    install -d -m755 "$temp/persist/etc/ssh"
    ssh-keygen -t ed25519 -N "" -C "<hostname>" -f "$temp/persist/etc/ssh/ssh_host_ed25519_key"
    ```
3. Push the button:
    ```
    nix run github:nix-community/nixos-anywhere#nixos-anywhere -- --extra-files "$temp" --flake /home/mydir/heim#hostname --target-host root@<hostname>
    ```

> [!IMPORTANT]  
> I ran into an issue where `nixos-anywhere` doesn't export the ZFS pool after installation.
> See https://github.com/nix-community/nixos-anywhere/issues/156
>
> A workaround is to add `--no-reboot` to the install command and manually export the pool before rebooting.

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
- [Misterio77 Nix Starter Config](https://github.com/Misterio77/nix-starter-configs)
- [hlissner's dotfiles](https://github.com/hlissner/dotfiles)
- [EmergentMind nix-config](https://github.com/EmergentMind/nix-config)
