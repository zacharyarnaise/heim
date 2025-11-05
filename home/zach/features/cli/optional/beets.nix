{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ffmpeg-headless
      ;
  };

  programs.beets = {
    enable = true;

    settings = {
      library = "/storage/data01/beets/library.db";
      directory = "/storage/sb01/music";
      original_date = true;
      plugins = builtins.concatStringsSep " " [
        "edit"
        "replaygain"
        "musicbrainz"
        "scrub"
        "lastgenre"
        "lyrics"
        "autobpm"
      ];
      paths = {
        default = "$albumartist/$album%aunique{}/$track $title";
        singleton = "Non-Album/$artist/$title";
        comp = "Compilations/$album%aunique{}/$track $title";
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
      lyrics = {
        auto = true;
        force = true;
        sources = ["lrclib" "tekstowo"];
        synced = true;
      };
      replaygain = {
        backend = "ffmpeg";
        overwrite = true;
      };
    };
  };

  home.persistence."/persist" = {
    files = [
      ".config/beets/state.pickle"
    ];
  };
}
