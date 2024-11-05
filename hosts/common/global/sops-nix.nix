{
  inputs,
  config,
  ...
}: let
  secretsDir = builtins.toString inputs.secrets;
  secretsFile = "${secretsDir}/secrets.yaml";

  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  hostKeys = builtins.filter isEd25519 config.services.openssh.hostKeys;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = "${secretsFile}";
    age = {
      sshKeyPaths = builtins.map getKeyPath hostKeys;
    };
  };
}
