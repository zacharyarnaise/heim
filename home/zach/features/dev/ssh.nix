{
  lib,
  config,
  inputs,
  outputs,
  ...
}: let
  inherit (inputs) secrets;

  hostNames = lib.attrNames outputs.nixosConfigurations;
  hostsConfig = lib.genAttrs hostNames (hostname: {
    host = hostname;
    hostname = secrets.hosts.${hostname}.inet;
    identitiesOnly = true;
    identityFile = ["/persist${config.home.homeDirectory}/.ssh/id_zach_sk"];
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
        ControlPersist = "5m";
      };
    }
    // hostsConfig // privateConfig;

  home.file = {
    ".ssh/sockets/.keep".text = "";
  };
}
