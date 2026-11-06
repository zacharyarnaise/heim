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
        AddKeysToAgent = lib.mkDefault false;
        AddressFamily = "inet";
        Ciphers = ["aes256-gcm@openssh.com" "chacha20-poly1305@openssh.com" "aes128-gcm@openssh.com"];
        ControlMaster = lib.mkDefault false;
        ControlPersist = lib.mkDefault false;
        ForwardAgent = lib.mkDefault false;
        HashKnownHosts = true;
        HostKeyAlgorithms = ["ssh-ed25519" "rsa-sha2-512"];
        KexAlgorithms = [
          "mlkem768x25519-sha256"
          "sntrup761x25519-sha512"
          "sntrup761x25519-sha512@openssh.com"
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
        ];
        MACs = ["hmac-sha2-512-etm@openssh.com" "hmac-sha2-256-etm@openssh.com"];
        ServerAliveCountMax = 4;
        ServerAliveInterval = 30;
        StrictHostKeyChecking = "ask";
        UserKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
      };

      "github.com" = {
        Host = "github.com";
        User = "git";
        IdentitiesOnly = !isHeadless;
        IdentityFile = lib.optionals (!isHeadless) identityFiles;
      };
    };
  };
}
