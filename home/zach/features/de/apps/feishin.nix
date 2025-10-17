{pkgs, ...}: {
  home.packages = [
    (pkgs.symlinkJoin
      {
        name = "feishin";
        paths = [pkgs.feishin];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/feishin \
            --prefix PATH : ${pkgs.mpv-unwrapped}/bin
        '';
      })
  ];

  services.playerctld.enable = true;

  home.persistence = {
    "/persist" = {
      directories = [
        ".config/feishin"
      ];
    };
  };
}
