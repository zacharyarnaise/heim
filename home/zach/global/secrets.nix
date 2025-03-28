{
  inputs,
  config,
  lib,
  ...
}: let
  homeDir = config.home.homeDirectory;
  secretsDir = builtins.toString inputs.secrets;
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    age.keyFile = "${homeDir}/.config/sops/age/keys.txt";
    defaultSopsFile = "${secretsDir}/users/zach/secrets.yaml";

    secrets = lib.mkIf (config.hostSpec.kind != "headless") {
      "u2f".path = "${homeDir}/.config/Yubico/u2f_keys";
    };
  };
}
