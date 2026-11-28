<div align = center>

# ~/heim
[![Built with Nix badge](https://img.shields.io/badge/Built%20with%20Nix%20and%20%E2%9D%A4%EF%B8%8F-5277C3?logo=nixos&logoColor=FFFFFF)](https://builtwithnix.org/)

Here you'll find my [NixOS](https://nixos.org/) & [home-manager](https://github.com/nix-community/home-manager) configurations for my systems, declared as a single Nix flake.

</div>

## Features
- Declarative disk partitioning ([disko](https://github.com/nix-community/disko))
- Full disk encryption
- [Impermanence](https://github.com/nix-community/impermanence), ephemeral root in tmpfs
- Secure Boot ([Limine](https://limine-bootloader.org/) + [sbctl](https://github.com/Foxboron/sbctl))
- Secrets provisioning using a separate private repo ([sops-nix](https://github.com/Mic92/sops-nix))
- Remote unattended bootstrapping via SSH ([nixos-anywhere](https://github.com/nix-community/nixos-anywhere))
- [Hyprland](https://hyprland.org/)
  - <details>
    <summary>Components</summary>

    - Shell: [Noctalia](https://github.com/noctalia-dev/noctalia-shell)
    - Display manager: [ly](https://codeberg.org/fairyglade/ly)
    - File manager (TUI): [yazi](https://github.com/sxyazi/yazi)
    - Terminal: [foot](https://codeberg.org/dnkl/foot)
    - Theming: [stylix](https://github.com/nix-community/stylix)

    </details>

<p align="center">
  <img width="1920" height="1080" alt="Screenshot showing fastfetch opened" src="https://github.com/user-attachments/assets/4fa46608-7654-43ec-9d09-58ea5e9cff6a" />
  <img width="960" height="540" alt="Screenshot showing various windows opened" src="https://github.com/user-attachments/assets/979652ce-d93d-480d-8f38-f218c8bd35d3" />
  <br>
  <sup>Wallpaper is Georg Pezolt - Salzburg von einer Loggia (1850)</sup>
</p>

## Repo structure
```sh
.
├─ home/              # Home-manager configurations
├─ hosts/             # NixOS configurations
│  ├─ common/ # Shared configurations
│    ├─ global/   # Config shared by all hosts
│    ├─ optional/ # Optional configurations
│    ├─ users/    # Host-level user declaration
│  ├─ calcifer/  # Desktop
│  ├─ jiji/      # Headless - WireGuard + Atuin, Navidrome, Nextcloud and slskd
│  ├─ noface/    # Headless - VirtualBox guest used for debugging/testing
│  ├─ ponyo/     # Laptop
├─ lib/               # Nix utilities/helpers
├─ modules/           # Reusable, abstract pieces of config for home-manager, NixOS or both.
│  ├─ common/
│  ├─ home-manager/
│  ├─ nixos/
├─ overlays/          # Overrides/patches for some packages
├─ pkgs/              # Custom packages
├─ checks.nix         # pre-commit-check config
├─ flake.nix          # Entrypoint for hosts and home-manager configs
├─ justfile           # Common commands, run `just` to list them
└─ shell.nix          # devShell with the tooling (nix develop / direnv)
```

## Bootstrapping a new host
### On the target host
1. Follow [these instructions](https://nixos.org/manual/nixos/stable/index.html#sec-booting-from-usb) to boot NixOS minimal installer
2. Set a password for `root` to allow for SSH access
### On an existing NixOS machine
1. Declare the new host in this repository
2. Push the button from the devShell:
    ```sh
    just bootstrap <hostname> <target-ip>
    ```
   It will generate SSH host key, prints its age recipient and public key, then pauses.
3. While paused, in the secrets repo: add the age recipient to `.sops.yaml`, encrypt its secrets and
   add the public key as `hosts/<hostname>/ssh_host_ed25519_key.pub`.

> [!IMPORTANT]
> If you use ZFS, `nixos-anywhere` has [an issue](https://github.com/nix-community/nixos-anywhere/issues/156) where it won't export the pool before rebooting.
>
> Possible workarounds:
> - append `--no-reboot` to the install command and manually export the pool before rebooting.
> - use the same `networking.hostId` as the NixOS installer and nixos-anywhere as demonstrated [here](https://github.com/nix-community/srvos/blob/755578b01c9fb1cc0a798c0d4d54a283077b315d/nixos/common/zfs.nix#L8).

## References & Useful resources
Resources that helped me find light down this rabbit hole:
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [Unmoved Centre blog posts](https://unmovedcentre.com/tags/nixos/)
- [NixOS & Flakes book](https://nixos-and-flakes.thiscute.world/)
- [How to learn Nix](https://ianthehenry.com/posts/how-to-learn-nix/)
- [Flakes introduction](https://www.tweag.io/blog/2020-05-25-flakes/)

Other people's configurations that inspired me:
- [Misterio77 Nix Starter Config](https://github.com/Misterio77/nix-starter-configs)
- [hlissner's dotfiles](https://github.com/hlissner/dotfiles)
- [EmergentMind nix-config](https://github.com/EmergentMind/nix-config)
