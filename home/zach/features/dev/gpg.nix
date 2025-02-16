{
  inputs,
  config,
  pkgs,
  ...
}: let
  secretsDir = builtins.toString inputs.secrets;
in {
  services.gpg-agent = {
    enable = true;

    defaultCacheTtl = 3600;
    enableScDaemon = false;
    enableSshSupport = false;
    enableZshIntegration = config.programs.zsh.enable;
    pinentryPackage = pkgs.pinentry-tty;
  };

  programs.gpg = {
    enable = true;

    mutableKeys = false;
    mutableTrust = false;
    publicKeys = [
      {
        source = "${secretsDir}/users/zach/gpg.pub";
        trust = 5;
      }
    ];
    settings = {
      no-greeting = true;
      keyid-format = "0xlong";
      with-fingerprint = true;
    };
  };
}
