{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ffmpeg-headless
      ;
  };

  programs.beets = {
    enable = true;
    package = pkgs.stable.beets;

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
          media = ["CD" "Digital Media|File"];
          original_year = true;
        };
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
