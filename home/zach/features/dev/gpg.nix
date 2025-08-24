{
  inputs,
  config,
  pkgs,
  ...
}: let
  cacheTTL = 300;
  secretsDir = builtins.toString inputs.secrets;
in {
  services.gpg-agent = {
    enable = true;

    defaultCacheTtl = cacheTTL;
    maxCacheTtl = cacheTTL;
    enableScDaemon = true;
    enableSshSupport = false;
    enableZshIntegration = config.programs.zsh.enable;
    pinentry.package = pkgs.pinentry-rofi.override {
      rofi = config.programs.rofi.package;
    };
  };

  programs.gpg = {
    enable = true;

    publicKeys = [
      {
        source = "${secretsDir}/users/zach/gpg.pub";
        trust = 5;
      }
      {
        source = pkgs.fetchurl {
          url = "https://github.com/web-flow.gpg";
          hash = "sha256-bor2h/YM8/QDFRyPsbJuleb55CTKYMyPN4e9RGaj74Q=";
        };
        trust = 4;
      }
    ];

    mutableKeys = false;
    mutableTrust = false;
    scdaemonSettings.disable-ccid = true;
    settings = {
      keyid-format = "long";
      use-agent = true;
      exit-on-status-write-error = true;
      no-greeting = true;
      with-subkey-fingerprint = true;
      no-comments = true;
      no-emit-version = true;
      export-options = "export-minimal";
      throw-keyids = true;
      armor = true;
      require-secmem = true;

      personal-cipher-preferences = "AES256";
      personal-digest-preferences = "SHA512";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 AES256 ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      s2k-digest-algo = "SHA512";
      s2k-mode = "3";
      s2k-count = "65000000";
    };
  };
}
