{
  inputs,
  config,
  lib,
  ...
}: let
  secretsDir = builtins.toString inputs.secrets;
  hostName = config.hostSpec.name;
  normalUsers = lib.filterAttrs (_: v: v.isNormalUser) config.users.users;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = "${secretsDir}/hosts/${hostName}/secrets.yaml";

    secrets =
      lib.mapAttrs' (n: _: {
        name = "passwords/${n}";
        value = {neededForUsers = true;};
      })
      normalUsers;
  };
}
