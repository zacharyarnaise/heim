{
  pkgs,
  config,
  lib,
  ...
}: let
  storePath = "/persist${config.home.homeDirectory}/.local/share/gopass/stores/root";
in {
  home = {
    packages = builtins.attrValues {
      inherit
        (pkgs)
        gopass
        gopass-jsonapi
        ;
    };

    file = {
      ".config/gopass/config".text = ''
        [mounts]
            path = ${storePath}
      '';
    };

    activation = let
      cmd = ''echo "Y" | ${pkgs.gopass-jsonapi}/bin/gopass-jsonapi configure --browser firefox --global=false --path=${config.home.homeDirectory}/.config/gopass --print=false'';
    in {
      gopassBrowser = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ -d "${storePath}/.git" ]; then
          run --quiet ${cmd}
        else
          warnEcho "Skipping, password store not initialized."
        fi
      '';
    };
  };
}
