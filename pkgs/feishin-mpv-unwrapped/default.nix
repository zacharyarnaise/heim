{pkgs}: (pkgs.symlinkJoin {
  name = "feishin-mpv-unwrapped";
  paths = [pkgs.feishin];
  nativeBuildInputs = [pkgs.makeWrapper];
  postBuild = ''
    wrapProgram $out/bin/feishin \
      --prefix PATH : "${pkgs.mpv-unwrapped}/bin"
  '';
})
