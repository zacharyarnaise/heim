{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  secretsDir = builtins.toString inputs.secrets;
  hostName = config.networking.hostName;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  environment.systemPackages = with pkgs; [
    age
    ssh-to-age
    sops
  ];

  sops = {
    secrets = {
      host =
        {
          sopsFile = "${secretsDir}/hosts/${hostName}/secrets.yaml";
        }
        // lib.optionalAttrs (lib.attrValues config.users.users) (user: {
          "passwords/${user.name}".neededForUsers = true;
        });
    };
  };
}
