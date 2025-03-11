{pkgs, ...}: {
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      yubikey-manager
      yubioath-flutter
      pam_u2f
      ;
  };

  hardware.gpgSmartcards.enable = true;
  services.pcscd.enable = true;

  security.pam = {
    u2f = {
      enable = true;
      control = "sufficient";
      settings.cue = true;
    };
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };
}
