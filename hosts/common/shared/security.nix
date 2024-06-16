{
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  programs.ssh = {
    enableAskPassword = false;
    hostKeyAlgorithms = [
      "ssh-ed25519"
      "ecdsa-sha2-nistp256"
      "ecdsa-sha2-nistp384"
      "ecdsa-sha2-nistp521"
      "rsa-sha2-512"
      "rsa-sha2-256"
      "ssh-rsa"
    ];
  };

  services.openssh = {
    allowSFTP = false;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      UseDns = false;
      X11Forwarding = false;

      Ciphers = [
        "chacha20-poly1305@openssh.com"
      ];
      KexAlgorithms = [
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
      ];
    };
  };
}
