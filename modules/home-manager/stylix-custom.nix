{
  config,
  lib,
  ...
}: {
  options.stylix.cursor = {
    xcursor-size = lib.mkOption {
      description = "The cursor size for the X11 cursor theme.";
      type = lib.types.int;
      default = config.stylix.cursor.size;
    };
  };

  config.home.sessionVariables = {
    XCURSOR_SIZE = toString config.stylix.cursor.xcursor-size;
  };
}
