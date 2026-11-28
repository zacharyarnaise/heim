[private]
default:
    @just --list

# Build and activate the new configuration, and make it the boot default
[group("local")]
switch host=`hostname`:
    nh os switch . -H {{ host }}

# Build the new configuration and make it the boot default
[group("local")]
boot host=`hostname`:
    nh os boot . -H {{ host }}

# Build and activate the new configuration
[group("local")]
test host=`hostname`:
    nh os test . -H {{ host }}

# Build the new configuration
[group("local")]
build host=`hostname`:
    nh os build . -H {{ host }}

# Diff a build from a git rev against the working tree
[arg("rev", long="rev")]
[group("local")]
diff host=`hostname` rev="HEAD":
    #!/usr/bin/env bash
    set -euo pipefail
    sha=$(git rev-parse "{{ rev }}")
    nh os build "git+file://$PWD?rev=$sha" -H {{ host }} -d never -o "result-{{ host }}-${sha:0:7}"
    nh os build . -H {{ host }} -d never -o "result-{{ host }}-tree"
    dix diff "result-{{ host }}-${sha:0:7}" "result-{{ host }}-tree"

# Build locally and switch a remote host
[group("remote")]
deploy host:
    nh os switch . -H {{ host }} --target-host {{ host }} -e empty-password

# Generate a host key, pause for secrets management, then install with nixos-anywhere
[group("remote")]
bootstrap host target:
    #!/usr/bin/env bash
    set -euo pipefail
    dir=$(mktemp -d)
    trap 'rm -rf "$dir"' EXIT
    key="$dir/persist/etc/ssh/ssh_host_ed25519_key"
    install -d -m755 "$(dirname "$key")"
    ssh-keygen -t ed25519 -N "" -C "{{ host }}" -f "$key"
    echo "age recipient: $(ssh-to-age < "$key.pub")"
    echo "public key: $(cat "$key.pub")"
    read -rp "Encrypt the host's secrets, add its public key to heim-secrets and push, then press Enter "
    nix flake update secrets
    nix run github:nix-community/nixos-anywhere -- --extra-files "$dir" --flake .#{{ host }} --target-host root@{{ target }}

# Update all inputs
[group("flake")]
update:
    nix flake update

# Update secrets input
[group("flake")]
update-secrets:
    nix flake update secrets

# Run pre-commit checks
[group("flake")]
check:
    nix flake check

# Format all Nix files
[group("flake")]
fmt:
    nix fmt ./
