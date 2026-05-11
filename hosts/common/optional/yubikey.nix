{
  config,
  pkgs,
  ...
}: let
  inherit (config.sops) secrets;
in {
  environment.systemPackages = [pkgs.pam_u2f];

  hardware.gpgSmartcards.enable = true;
  services.pcscd.enable = true;

  sops.secrets = {
    "u2f" = {};
  };

  security.pam = {
    u2f = {
      enable = true;
      control = "sufficient";
      settings = {
        cue = true;
        authfile = secrets."u2f".path;
      };
    };
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };
}
