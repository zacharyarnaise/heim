{inputs, ...}: rec {
  # Root directory of the flake
  root = ../.;

  # Root directory of the secrets
  secrets = builtins.toString inputs.secrets;

  # Get the directory containing the secrets of a given host.
  hostSecrets = hostname: "${secrets}/hosts/${hostname}";

  # Get the directory containing the secrets of a given user.
  userSecrets = username: "${secrets}/home/${username}";
}
