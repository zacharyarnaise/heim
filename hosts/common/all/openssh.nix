{
  config,
  lib,
  outputs,
  utils,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;

  hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  programs.ssh = {
    knownHosts = lib.genAttrs hosts (hostname: {
      extraHostNames = ["${hostname}.zzz"];
      publicKey =
        builtins.readFile ((utils.hostSecretsDir hostname) + "/ssh_host_ed25519_key.pub");
    });
  };

  services.openssh = {
    enable = true;
    allowSFTP = lib.mkDefault false;

    hostKeys = [
      {
        path = "${lib.optionalString hasOptinPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];

    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StrictModes = true;
      X11Forwarding = false;

      Ciphers = [
        "chacha20-poly1305@openssh.com"
      ];
      KexAlgorithms = [
        "sntrup761x25519-sha512@openssh.com"
      ];
    };

    extraConfig = ''
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AllowTcpForwarding no
    '';
  };
}
