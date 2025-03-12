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

  hostNames = lib.attrNames outputs.nixosConfigurations;
  hostsConfig = lib.genAttrs (lib.dag.entryAfter ["*"] hostNames) (hostname: {
    host = hostname;
    hostname = "${inputs.secrets.hosts.${hostname}.inet}";
    forwardAgent = true;
    identitiesOnly = true;
    identityFile = identityFiles;
  });
in {
  programs.ssh = {
    addKeysToAgent = "yes";
    controlMaster = "auto";
    controlPath = "~/.ssh/sockets/control-%r@%h:%p";
    controlPersist = "15m";

    matchBlocks = hostsConfig;
  };

  home.file = {
    ".ssh/sockets/.keep".text = "";
  };
}
