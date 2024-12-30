{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  secretsDir = builtins.toString inputs.secrets;
  hostName = config.networking.hostName;
  normalUsers = lib.filterAttrs (_: v: v.isNormalUser) config.users.users;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  environment.systemPackages = with pkgs; [
    age
    ssh-to-age
    sops
  ];

  sops = {
    secrets =
      {sopsFile = "${secretsDir}/hosts/${hostName}/secrets.yaml";}
      // (
        lib.mapAttrs' (n: _: {
          name = "passwords/${n}";
          value = {neededForUsers = true;};
        })
        normalUsers
      );
  };
}
