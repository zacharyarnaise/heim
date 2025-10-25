{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ffmpeg-headless
      ;
  };

  programs.beets = {
    enable = true;
    package = pkgs.stable.beets.override {
      extraPatches = [
        # Don't send user-agent bc some lyrics providers block it
        (pkgs.fetchpatch {
          url = "https://github.com/beetbox/beets/commit/095c69a853f6de70f131a1bfc62256e3d2c5cebe.patch";
          hash = "sha256-CsJwQiXiRk3f5NFMuodpsb+lD3u3pbOzEejip5X28Po=";
        })
      ];
    };

    settings = {
      library = "/storage/data01/beets/library.db";
      directory = "/storage/sb01/music";
      original_date = true;
      plugins = builtins.concatStringsSep " " [
        "edit"
        "replaygain"
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
