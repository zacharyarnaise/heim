{
  lib,
  config,
  ...
}: let
  isHeadless = config.hostSpec.kind == "headless";
  identityFiles =
    lib.lists.forEach [
      "id_zach_sk"
    ]
    (n: "/persist${config.home.homeDirectory}/.ssh/${n}");
in {
  home.persistence."/persist/${config.home.homeDirectory}" = {
    allowOther = false;
    directories = [
      {
        directory = ".ssh/known_hosts.d";
        method = "symlink";
      }
    ];
  };

  programs.ssh = {
    enable = true;

    hashKnownHosts = true;
    userKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
    serverAliveCountMax = 3;
    serverAliveInterval = 5;

    matchBlocks = {
      "github.com" = {
        host = "github.com";
        user = "git";
        forwardAgent = isHeadless;
        identitiesOnly = !isHeadless;
        identityFile =
          if isHeadless
          then []
          else identityFiles;
      };
    };
  };
}
