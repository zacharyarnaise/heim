{
  imports = [
    ./global
  ];

  programs.beets = {
    enable = true;

    settings = {
      library = "/storage/data01/beets/library.db";
      directory = "/storage/sb01/music";
      plugins = builtins.concatStringsSep " " [
        "fetchart"
        "thumbnails"
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
      fetchart = {
        cautious = true;
        sources = "coverart itunes amazon albumart filesystem";
        minwidth = 1200;
        maxwidth = 1800;
        enforce_ratio = true;
        quality = 80;
        max_filesize = 1048576;
        cover_format = "JPEG";
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
