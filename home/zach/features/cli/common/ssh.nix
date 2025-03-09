{
  lib,
  config,
  ...
}: {
  home.persistence = {
    "/persist${config.home.homeDirectory}" = {
      allowOther = false;
      directories = [".ssh/known_hosts.d"];
    };
  };

  programs.ssh = {
    enable = true;

    forwardAgent = false;
    hashKnownHosts = true;
    userKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
    serverAliveCountMax = 3;
    serverAliveInterval = 5;

    matchBlocks = {
      "github.com" = {
        host = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = lib.lists.forEach [
          "id_ed25519"
        ] (n: "/persist${config.home.homeDirectory}/.ssh/${n}");
      };
    };
  };
}
