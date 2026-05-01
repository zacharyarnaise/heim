{lib, ...}: {
  programs.eza = {
    enable = true;
    enableFishIntegration = lib.mkForce false; # Don't want default aliases

    extraOptions = ["--group-directories-first"];
    icons = "auto";
    git = true;
  };
}
