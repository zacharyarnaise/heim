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

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      openssl
      postgresql_17
      redpanda-client
      sops
      ;
  };
}
