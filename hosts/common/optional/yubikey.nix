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
        authfile = secrets."u2f".path;
        cue = true;
      };
    };
    services = {
      login.u2f.enable = true;
      sudo.u2f.enable = true;
    };
  };
}
