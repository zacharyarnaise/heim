{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [inputs.dms.homeModules.dank-material-shell];
  programs.dank-material-shell = {
    enable = true;
    enableVPN = false;
    systemd.enable = true;

    clipboardSettings = import ./clsettings.nix;
    session = import ./session.nix {inherit (inputs) secrets;};
    settings = import ./settings.nix {inherit config lib;};
  };

  home.file.".config/DankMaterialShell/.firstlaunch".text = "";
}
