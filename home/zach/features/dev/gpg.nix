{
  inputs,
  config,
  pkgs,
  ...
}: let
  cacheTTL =
    if !config.isLaptop
    then 3600
    else 0;
  secretsDir = builtins.toString inputs.secrets;
in {
  services.gpg-agent = {
    enable = true;

    defaultCacheTtl = cacheTTL;
    defaultCacheTtlSsh = cacheTTL;
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
      keyid-format = "long";
      use-agent = true;
      exit-on-status-write-error = true;
      no-greeting = true;
      with-subkey-fingerprint = true;
      no-comments = true;
      export-options = "export-minimal";
      personal-cipher-preferences = "AES256";
      personal-digest-preferences = "SHA512";
      cipher-algo = "AES256";
      digest-algo = "SHA512";
      cert-digest-algo = "SHA512";
      s2k-mode = "3";
      s2k-count = "65000000";
    };
  };
}
