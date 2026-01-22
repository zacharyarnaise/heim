{pkgs, ...}: {
  imports = [
    ./abbreviations.nix
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
        name = "fzf-fish";
        inherit (pkgs.fishPlugins.fzf-fish) src;
      }
      {
        name = "plugin-sudope";
        inherit (pkgs.fishPlugins.plugin-sudope) src;
      }
    ];
  };
}
