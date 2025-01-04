{
  lib,
  config,
  ...
}: {
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

    matchBlocks = {
      "github.com" = {
        host = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = lib.lists.forEach [
          "id_ed25519"
        ] (n: "${config.home.homeDirectory}/.ssh/${n}");
      };
    };
  };
}
