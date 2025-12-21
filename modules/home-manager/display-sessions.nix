{lib, ...}: {
  options = {
    home.displaySessions = lib.mkOption {
      type = lib.types.listOf (
        lib.types.package
        // {
          description = "package with provided sessions";
          check = p:
            lib.assertMsg
            (
              lib.types.package.check p
              && p ? providedSessions
              && p.providedSessions != []
              && lib.all lib.isString p.providedSessions
            )
            ''
              Package, '${p.name}', did not specify any session names, as strings, in
              'passthru.providedSessions'. This is required when used as a session package.

              The session names can be looked up in:
                ${p}/share/xsessions
                ${p}/share/wayland-sessions
            '';
        }
      );
      default = [];
      description = ''
        A list of packages containing x11 or wayland session files
        to be passed to the display manager.
        This is equivalent to {option}`services.displayManager.sessionPackages`,
        it only exists for convenience of defining sessions entirely in home configurations.
      '';
    };
  };
}
