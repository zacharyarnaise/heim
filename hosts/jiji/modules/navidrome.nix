{config, ...}: let
  inherit (config.sops) secrets;
in {
  sops.secrets = let
    names = [
      "navidrome"
    ];
  in
    builtins.listToAttrs (map (name: {
        inherit name;
        value = {
          group = "navidrome";
          owner = "navidrome";
        };
      })
      names);

  services.navidrome = {
    enable = true;
    openFirewall = true;

    environmentFile = secrets.navidrome.path;
    settings = {
      Address = "10.0.1.2";
      Port = 4533;
      MusicFolder = "/storage/sb01/music";
      DataFolder = "/storage/data01/navidrome/data";
      LogLevel = "info";
      EnableInsightsCollector = false;

      AutoImportPlaylists = false;
      CovertArtPriority = "*.jpg, *.JPG, *.jpeg, *.JPEG, *.png, *.PNG, embedded";
      CoverJpegQuality = 80;
      DefaultUIVolume = 50;
      EnableFavourites = true;
      EnableMediaFileCoverArt = false;
      EnableStarRating = true;
      "LastFM.Enabled" = true;
      "Scanner.WatcherWait" = "1m";
      SessionTimeout = "72h";
      UIWelcomeMessage = "( ͡° ͜ʖ ͡°)";
    };
  };
}
