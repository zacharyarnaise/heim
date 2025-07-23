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
        "edit"
        "fetchart"
        "inline"
        "thumbnails"
      ];
      paths = {
        default = "$albumartist/$album%aunique{}/$track $title";
        singleton = "Non-Album/$artist/$title";
        comp = "Compilations/$album%aunique{}/$track $title";
      };
    };
  };
}
