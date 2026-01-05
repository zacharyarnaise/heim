{
  lib,
  config,
  ...
}: {
  services.hyprpaper = {
    enable = true;

    settings = lib.mkForce {
      ipc = false;
      splash = false;
      # Workaround until https://github.com/nix-community/stylix/pull/2087 is merged
      wallpaper = {
        monitor = "";
        path = config.stylix.image;
      };
    };
  };
}
