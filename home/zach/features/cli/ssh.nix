{config, ...}: {
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
