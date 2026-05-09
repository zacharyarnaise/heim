{inputs, ...}: {
  imports = [inputs.dms.homeModules.dank-material-shell];
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
  };

  home.file.".config/DankMaterialShell/.firstlaunch".text = "";
}
