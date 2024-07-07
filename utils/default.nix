{inputs, ...}: let
  secretsDir = builtins.toString inputs.secrets;
in {
  rootDir = ../.;

  secretsDir = secretsDir;
  hostSecretsDir = hostname: secretsDir + "/hosts/" + hostname;
  userSecretsDir = username: secretsDir + "/home/" + username;
}
