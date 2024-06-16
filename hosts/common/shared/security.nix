{
  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
  };

  services = {
    openssh = {
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
  };
}
