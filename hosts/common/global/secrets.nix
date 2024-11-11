{
  inputs,
  config,
  pkgs,
  ...
}: let
  secretsDir = builtins.toString inputs.secrets;
  hostName = config.networking.hostName;
  userName = config.home.username;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  environment.systemPackages = with pkgs; [
    age
    ssh-to-age
    sops
  ];

  sops = {
    secrets = {
      host = {
        sopsFile = "${secretsDir}/hosts/${hostName}/secrets.yaml";
        "passwords/${userName}".neededForUsers = true;
      };

      user = {
        sopsFile = "${secretsDir}/users/${userName}/secrets.yaml";
        validateSopsFile = false;
      };
    };
  };
}
