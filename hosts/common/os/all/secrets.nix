{inputs, ...}: let
  sopsFile = builtins.toString (inputs.secrets) + "/secrets.yaml";
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = sopsFile;
  };
}
