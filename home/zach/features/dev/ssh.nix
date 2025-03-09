{
  programs.ssh = {
    addKeysToAgent = "yes";
    controlMaster = "auto";
    controlPath = "~/.ssh/sockets/control-%r@%h:%p";
    controlPersist = "15m";
  };

  home.file = {
    ".ssh/sockets/.keep".text = "";
  };
}
