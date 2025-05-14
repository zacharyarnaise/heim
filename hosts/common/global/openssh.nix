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
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StrictModes = true;
      X11Forwarding = false;
      UseDns = false;

      Ciphers = [
        "chacha20-poly1305@openssh.com"
      ];
      KexAlgorithms = [
        "sntrup761x25519-sha512@openssh.com"
      ];
    };
  };

  security.pam = {
    rssh.enable = true;
    services.sudo.rssh = true;
  };
}
