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
  services = {
    pcscd.enable = true;
    udev.packages = [pkgs.yubikey-personalization];
    yubikey-agent.enable = true;
  };

  security.pam = {
    u2f = {
      enable = true;
      settings.cue = true;
    };
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };
}
