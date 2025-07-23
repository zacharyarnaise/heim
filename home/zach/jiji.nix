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
        default = "library/$albumartist/$album%aunique{}/$track $title";
        singleton = "library/Non-Album/$artist/$title";
        comp = "library/Compilations/$album%aunique{}/$track $title";
      };
      import = {
        copy = false;
        move = true;
      };
    };
  };
}
