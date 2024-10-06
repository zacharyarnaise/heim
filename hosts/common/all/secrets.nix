{inputs, ...}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = builtins.toString inputs.secrets + "/secrets.yaml";
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  };
}
