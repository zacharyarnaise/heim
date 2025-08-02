{
  imports = [
    ./global
  ];

  programs.beets = {
    enable = true;

    settings = {
      library = "/storage/data01/beets/library.db";
      directory = "/storage/sb01/music";
      original_date = true;
      plugins = builtins.concatStringsSep " " [
        "thumbnails"
        "edit"
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
    };
  };
}
