{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ffmpeg-headless
      imagemagick
      ;
  };

  programs.beets = {
    enable = true;

    settings = {
      library = "/storage/data01/beets/library.db";
      directory = "/storage/sb01/music";
      original_date = true;
      plugins = builtins.concatStringsSep " " [
        "info"
        "edit"
        "replaygain"
        "musicbrainz"
        "scrub"
        "lastgenre"
        "lyrics"
        "autobpm"
        "zero"
        "fetchart"
      ];
      paths = {
        default = "$albumartist/$original_year - $album%aunique{}/$track $title";
        singleton = "Non-Album/$artist/$title";
        comp = "Compilations/$original_year - $album%aunique{}/$track $title";
      };
      import = {
        copy = false;
        move = false;
        write = true;
      };
      match = {
        preferred = {
          media = ["Digital Media|File" "CD"];
          original_year = true;
        };
      };
      musicbrainz = {
        search_limit = 10;
      };
      lyrics = {
        auto = true;
        force = true;
        keep_synced = true;
        sources = ["lrclib" "lrcmux" "tekstowo"];
        synced = true;
      };
      replaygain = {
        backend = "ffmpeg";
        overwrite = true;
      };
      zero = {
        auto = true;
        fields = ["images"];
      };
      fetchart = {
        cautious = true;
        minwidth = 1000;
        maxwidth = 2000;
        max_filesize = 1024 * 1024; # In bytes
        enforce_ratio = true;
        sources = ["coverart" "itunes" "amazon" "albumart"];
        store_source = true;
        high_resolution = true;
        cover_format = "JPEG";
      };
    };
  };

  home.persistence."/persist" = {
    files = [
      ".config/beets/state.pickle"
    ];
  };
}
