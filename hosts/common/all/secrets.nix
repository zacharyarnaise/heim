{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = lib.dirs.secrets + "/secrets.yaml";
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  };
}
