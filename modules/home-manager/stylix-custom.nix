{
  config,
  lib,
  ...
}: {
  options.stylix.cursor = {
    gtk-size = lib.mkOption {
      description = "The cursor size for GTK applications.";
      type = lib.types.int;
      default = config.stylix.cursor.size;
    };
  };
}
