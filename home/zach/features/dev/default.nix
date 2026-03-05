{pkgs, ...}: {
  imports = [
    ./nixvim

    ./ansible.nix
    ./direnv.nix
    ./git.nix
    ./golang.nix
    ./gpg.nix
    ./k8s.nix
    ./nix.nix
    ./podman.nix
    ./python.nix
    ./ssh.nix
    ./tilt.nix
    ./vscode.nix
  ];

  home.packages = [
    pkgs.openssl
    pkgs.stable.pgbadger
    pkgs.postgresql_18
    pkgs.redpanda-client
    pkgs.sops
  ];
}
