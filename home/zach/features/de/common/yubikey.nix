{
  pkgs,
  config,
  ...
}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      yubikey-manager
      yubioath-flutter
      ;
  };

  sops.secrets = {
    u2f_keys = {path = "${config.home.homeDirectory}/.config/Yubico/u2f_keys";};
  };
}
