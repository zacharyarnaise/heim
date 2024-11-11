{lib, ...}: {
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  programs.ssh = {
    enableAskPassword = false;
  };

  # Provides sane defaults in case we enable OpenSSH somewhere
  services.openssh = {
    allowSFTP = lib.mkDefault false;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
      StrictModes = true;

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
