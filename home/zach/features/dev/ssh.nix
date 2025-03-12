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
    then secrets.work.ssh.matchBlocks
    else {};
in {
  programs.ssh = {
    addKeysToAgent = "yes";
    controlMaster = "auto";
    controlPath = "~/.ssh/sockets/control-%r@%h:%p";
    controlPersist = "15m";

    matchBlocks = hostsConfig // privateConfig;
  };

  home.file = {
    ".ssh/sockets/.keep".text = "";
  };
}
