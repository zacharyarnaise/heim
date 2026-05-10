{inputs, ...}: {
  imports = [inputs.dms.homeModules.dank-material-shell];
  programs.dank-material-shell = {
    enable = true;
    enableVPN = false;
    systemd.enable = true;

    clipboardSettings = import ./clipboardSettings.nix;
    session = import ./session.nix;
    settings = import ./settings.nix;
  };

  home.file.".config/DankMaterialShell/.firstlaunch".text = "";
}
