{
  inputs,
  config,
  pkgs,
  ...
}: let
  secretsDir = builtins.toString inputs.secrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  environment.systemPackages = with pkgs; [
    age
    ssh-to-age
    sops
  ];

  sops = {
    secrets = {
      common = {
        sopsFile = "${secretsDir}/common/secrets.yaml";
      };
      host = {
        sopsFile = "${secretsDir}/hosts/${config.networking.hostName}/secrets.yaml";
      };
      user = {
        sopsFile = "${secretsDir}/users/${config.home.username}/secrets.yaml";
      };
    };
  };
}
