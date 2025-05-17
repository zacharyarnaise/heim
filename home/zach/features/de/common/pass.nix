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

    activation.gopassBrowser = lib.hm.dag.entryAfter ["writeBoundary"] ''
      export PATH="${config.home.path}/bin:$PATH"
      echo "Y" | gopass-jsonapi configure --browser firefox --global=false --path=${config.home.homeDirectory}/.config/gopass
    '';
  };
}
