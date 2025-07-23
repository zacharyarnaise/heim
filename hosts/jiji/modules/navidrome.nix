{config, ...}: let
  inherit (config.sops) secrets;
in {
  sops.secrets = {
    "navidrome/passkey" = {};
    "navidrome/lastfm/apikey" = {};
    "navidrome/lastfm/secret" = {};
  };

  services.navidrome = {
    enable = true;
    openFirewall = true;

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
      EnableFavourites = false;
      EnableStarRating = false;
      "LastFM.Enabled" = true;
      "LastFM.ApiKey" = secrets."navidrome/lastfm/apikey".path;
      "LastFM.Secret" = secrets."navidrome/lastfm/secret".path;
      PasswordEncryptionKey = secrets."navidrome/passkey".path;
      "Scanner.WatcherWait" = "1m";
      SessionTimeout = "72h";
      UIWelcomeMessage = "( ͡° ͜ʖ ͡°)";
    };
  };
}
