{
  inputs,
  lib,
  outputs,
  ...
}: let
  userSecretsDir = builtins.toString (inputs.secrets) + "/home/zach";
in {
  users.users.zach = {
    isNormalUser = true;
    description = "Zach";
    extraGroups = [
      "network"
      "wheel"
    ];
    # hashedPasswordFile = config.sops.secrets.layla-password.path;
    # TODO: remove when things are working
    password = "testing";

    openssh.authorizedKeys.keys =
      lib.splitString "\n" (builtins.readFile userSecretsDir + "/id_ed25519.pub");
  };
}
