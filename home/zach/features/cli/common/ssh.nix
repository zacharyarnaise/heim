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
  home.persistence = {
    "/persist${config.home.homeDirectory}" = {
      allowOther = false;
      directories = [".ssh/known_hosts.d"];
    };
  };

  programs.ssh = {
    enable = true;

    hashKnownHosts = true;
    userKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
    serverAliveCountMax = 3;
    serverAliveInterval = 5;

    matchBlocks = {
      "github.com" = lib.hm.dag.entryAfter ["*"] {
        host = "github.com";
        user = "git";
        forwardAgent = isHeadless;
        identitiesOnly = true;
        identityFile =
          if isHeadless
          then []
          else identityFiles;
      };
    };
  };
}
