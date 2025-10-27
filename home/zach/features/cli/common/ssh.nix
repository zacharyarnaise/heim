{
  lib,
  config,
  pkgs,
  ...
}: let
  isHeadless = config.hostSpec.kind == "headless";
  identityFiles =
    lib.lists.forEach [
      "id_zach_sk"
    ]
    (n: "/persist${config.home.homeDirectory}/.ssh/${n}");
in {
  home.persistence."/persist" = {
    directories = [
      ".ssh/known_hosts.d"
    ];
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # Disable it, will be deprecated in the future
    package = pkgs.stable.openssh;

    matchBlocks = {
      "*" = {
        addKeysToAgent = lib.mkDefault "no";
        compression = false;
        controlMaster = lib.mkDefault "no";
        controlPersist = lib.mkDefault "no";
        hashKnownHosts = true;
        userKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
        serverAliveCountMax = 3;
        serverAliveInterval = 5;
      };

      "github.com" = {
        host = "github.com";
        user = "git";
        forwardAgent = isHeadless;
        identitiesOnly = !isHeadless;
        identityFile = lib.optionals (!isHeadless) identityFiles;
      };
    };
  };
}
