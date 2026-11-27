{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.vscode;
in {
  options.programs.vscode.trustedWorkspaces = lib.mkOption {
    type = lib.types.listOf lib.types.path;
    default = [];
    description = ''
      Sets the list of trusted workspace for VSCode.

      It hijacks state.vscdb (SQLite db) which is a bit hacky and might break out of the blue.
      A simpler, more robust approach is to just persist this file but I only care about
      trusted workspaces and it's nice to be able to manage them declaratively.
    '';
  };

  config = lib.mkIf (cfg.enable && cfg.trustedWorkspaces != []) {
    home.activation.vscodeTrustedWorkspaces = let
      db = "${config.home.homeDirectory}/.vscode-shared/sharedStorage/state.vscdb";
      trust = builtins.toJSON {
        uriTrustInfo =
          map (p: {
            uri = {
              "$mid" = 1;
              fsPath = toString p;
              external = "file://${toString p}";
              path = toString p;
              scheme = "file";
            };
            trusted = true;
          })
          cfg.trustedWorkspaces;
      };
      sql = ''
        CREATE TABLE ItemTable (key TEXT UNIQUE ON CONFLICT REPLACE, value BLOB);
        INSERT INTO ItemTable VALUES ('content.trust.model.key', '${trust}');
      '';
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ ! -e ${db} ]; then
          run mkdir -p ${dirOf db}
          run ${pkgs.sqlite}/bin/sqlite3 ${db} ${lib.escapeShellArg sql}
        fi
      '';
  };
}
