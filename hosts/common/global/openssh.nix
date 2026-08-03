{lib, ...}: {
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    allowSFTP = lib.mkDefault false;

    hostKeys = [
      {
        path = "/persist/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];

    settings = {
      ClientAliveCountMax = "3";
      ClientAliveInterval = "10";
      HostbasedAuthentication = false;
      IgnoreRhosts = true;
      KbdInteractiveAuthentication = false;
      LoginGraceTime = "10s";
      MaxAuthTries = "1";
      MaxStartups = "1";
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StrictModes = true;
      UseDns = false;
      X11Forwarding = false;

      Ciphers = ["chacha20-poly1305@openssh.com"];
      KexAlgorithms = ["mlkem768x25519-sha256" "sntrup761x25519-sha512" "sntrup761x25519-sha512@openssh.com"];
      Macs = ["hmac-sha2-512-etm@openssh.com" "hmac-sha2-512"];
    };
  };

  security.pam = {
    rssh.enable = true;
    services.sudo.rssh = true;
  };
}
