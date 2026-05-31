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
  home.persistence."/persist" = {
    directories = [
      ".ssh/known_hosts.d"
    ];
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        AddKeysToAgent = lib.mkDefault "no";
        Compression = lib.mkDefault "no";
        ControlMaster = lib.mkDefault "no";
        ControlPersist = lib.mkDefault "no";
        HashKnownHosts = true;
        ServerAliveCountMax = 3;
        ServerAliveInterval = 5;
        UserKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
      };

      "github.com" = {
        Host = "github.com";
        User = "git";
        ForwardAgent = isHeadless;
        IdentitiesOnly = !isHeadless;
        IdentityFile = lib.optionals (!isHeadless) identityFiles;
      };
    };
  };
}
