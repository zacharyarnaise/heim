{pkgs, ...}: {
  imports = [
    ./abbreviations.nix
    ./aliases.nix
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
    # Erasing also prevents fish from autoloading the stock cdh function
    interactiveShellInit = ''
      functions --erase cdh
    '';
    plugins = [
      {
        name = "forgit";
        inherit (pkgs.fishPlugins.forgit) src;
      }
      {
        name = "plugin-sudope";
        inherit (pkgs.fishPlugins.plugin-sudope) src;
      }
    ];
  };
}
