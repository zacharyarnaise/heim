{
  lib,
  config,
  inputs,
  outputs,
  ...
}: let
  identityFiles =
    lib.lists.forEach [
      "id_zach_sk"
    ]
    (n: "/persist${config.home.homeDirectory}/.ssh/${n}");

  inherit (inputs) secrets;

  hostNames = lib.attrNames outputs.nixosConfigurations;
  hostsConfig = lib.genAttrs hostNames (hostname: {
    host = hostname;
    hostname = "${secrets.hosts.${hostname}.inet}";
    forwardAgent = true;
    identitiesOnly = true;
    identityFile = identityFiles;
  });

  privateConfig =
    if config.hostSpec.isWork
    then secrets.work.ssh.settings
    else {};
in {
  programs.ssh.settings =
    {
      "*" = {
        AddKeysToAgent = "yes";
        ControlMaster = "auto";
        ControlPath = "~/.ssh/sockets/control-%r@%h:%p";
        ControlPersist = "15m";
      };
    }
    // hostsConfig // privateConfig;

  home.file = {
    ".ssh/sockets/.keep".text = "";
  };
}
