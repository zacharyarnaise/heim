{
  inputs,
  config,
  lib,
  ...
}: let
  hostName = config.hostSpec.name;
  normalUsers = lib.filterAttrs (_: v: v.isNormalUser) config.users.users;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = "${inputs.secrets}/hosts/${hostName}/secrets.yaml";

    secrets =
      lib.mapAttrs' (n: _: {
        name = "passwords/${n}";
        value = {neededForUsers = true;};
      })
      normalUsers;
  };
}
