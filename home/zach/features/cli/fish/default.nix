{pkgs, ...}: {
  imports = [
    ./abbreviations.nix
    ./colors.nix
    ./functions.nix
    ./starship.nix
  ];

  home.shell.enableFishIntegration = true;
  programs.fish = {
    enable = true;
    generateCompletions = true;
    preferAbbrs = true;

    functions = {
      fish_greeting = "";
    };
    plugins = [
      {
        name = "forgit";
        inherit (pkgs.fishPlugins.forgit) src;
      }
      {
        name = "plugin-sudope";
        src = pkgs.fishPlugins.plugin-sudope.src;
      }
    ];
  };
}
