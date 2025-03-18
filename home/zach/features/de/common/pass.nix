{
  pkgs,
  config,
  ...
}: let
  storePath = "/persist${config.home.homeDirectory}/.local/share/gopass/stores/root";
in {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      gopass
      gopass-jsonapi
      ;
  };

  home.file = {
    ".config/gopass/config".text = ''
      [mounts]
          path = ${storePath}
    '';
  };

  home.activation.gopassStore = ''
    #!/usr/bin/env bash

    if [ ! -d ${storePath} ] ; then
      mkdir -m 0750 -p ${storePath}
      git clone --depth=1 git@github.com:zacharyarnaise/pass.git ${storePath}
    fi

    echo "Y" | gopass-jsonapi configure --browser firefox --global=false --path=${config.home.homeDirectory}/.config/gopass
  '';
}
