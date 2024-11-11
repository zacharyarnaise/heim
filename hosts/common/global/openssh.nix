{
  config,
  lib,
  ...
}: let
  hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  programs.ssh = {
    knownHosts = {
      "github.com".publicKey = ''
        ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
      '';
    };
  };

  services.openssh = {
    enable = true;

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
    allowSFTP = lib.mkDefault false;
    extraConfig = ''
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AllowTcpForwarding no
    '';
  };
}
