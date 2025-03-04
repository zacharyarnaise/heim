{pkgs, ...}: {
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      yubikey-manager
      yubioath-flutter
      ;
  };
}
