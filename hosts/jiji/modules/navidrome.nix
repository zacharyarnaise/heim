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
      DataFolder = "/storage/data01/navidrome/data";
      MusicFolder = "/storage/sb01/music";
      EnableInsightsCollector = false;
      LogLevel = "warn";

      AutoImportPlaylists = false;
      CovertArtPriority = "cover.*";
      CoverArtQuality = 80;
      DefaultDownsamplingFormat = "opus";
      DefaultUIVolume = 50;
      DiscArtPriority = "";
      EnableFavourites = true;
      EnableMediaFileCoverArt = false;
      EnableStarRating = true;
      EnableTranscodingCancellation = true;
      EnableWebPEncoding = false;
      ImageCacheSize = "500MB";
      "LastFM.Enabled" = true;
      "ListenBrainz.Enabled" = true;
      LyricsPriority = "embedded";
      "Scanner.Enabled" = true;
      "Scanner.ScanOnStartup" = false;
      "Scanner.WatcherWait" = "1m";
      SessionTimeout = "72h";
      "Subsonic.AppendAlbumVersion" = false;
      TranscodingCacheSize = "5GB";
      UICoverArtSize = 500;
      UIWelcomeMessage = "( ͡° ͜ʖ ͡°)";
    };
  };

  systemd.services.navidrome.after = ["network-online.target" "storage-sb01-music.mount"];
}
