{
  inputs,
  config,
  ...
}: let
  secretsDir = builtins.toString inputs.secrets;
in {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${secretsDir}/users/zach/secrets.yaml";
  };
}
