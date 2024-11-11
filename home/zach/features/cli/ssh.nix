{
  outputs,
  lib,
  config,
  ...
}: let
  nixosConfigs = builtins.attrNames outputs.nixosConfigurations;
  homeConfigs = map (n: lib.last (lib.splitString "@" n)) (builtins.attrNames outputs.homeConfigurations);
  hostnames = lib.unique (homeConfigs ++ nixosConfigs);
in {
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".ssh/known_hosts.d"
    ];
  };

  programs.ssh = {
    enable = true;

    forwardAgent = false;
    hashKnownHosts = true;
    userKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
  };
}
