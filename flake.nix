{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Inputs used by all configurations
    nixos-hardware.url = "github:nixos/nixos-hardware";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      type = "git";
      url = "git+ssh://git@github.com/zacharyarnaise/heim-secrets.git";
      flake = true;
      ref = "main";
      shallow = true;
    };

    # Desktop specific inputs
    stylix.url = "github:danth/stylix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # nixpkgs.lib.extend (l: _: {extras = import ./lib.nix;}) // home-manager.lib;
    lib = nixpkgs.lib // home-manager.lib;

    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forEachSystem = f: lib.genAttrs supportedSystems (sys: f pkgsFor.${sys});
    pkgsFor = lib.genAttrs supportedSystems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );

    specialArgs = {inherit inputs outputs;};
    mkNixos = modules:
      lib.nixosSystem {
        inherit specialArgs modules;
      };
    mkHome = modules: systemName:
      lib.homeManagerConfiguration {
        modules = [./home/nixpkgs.nix] ++ modules;
        pkgs = pkgsFor.${systemName};
        extraSpecialArgs = specialArgs;
      };
  in {
    inherit lib;

    # Reusable custom modules for NixOS and home-manager
    nixosModules = import ./modules/nixos ./modules/common;
    homeManagerModules = import ./modules/home-manager ./modules/common;
    # Custom modifications/override to upstream packages
    overlays = import ./overlays {inherit inputs outputs;};
    # Custom packages to be shared or upstreamed
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    # Nix formatter available through 'nix fmt'
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # -- NixOS configurations --------------------------------------------------
    nixosConfigurations = {
      "calcifer" = mkNixos [./hosts/calcifer];
      "howl" = mkNixos [./hosts/howl];
      "laptop-gb" = mkNixos [./hosts/laptop-gb];
      "noface" = mkNixos [./hosts/noface];
    };

    # -- home-manager configurations -------------------------------------------
    homeConfigurations = {
      "zach@calcifer" = mkHome [./home/zach/calcifer.nix] "x86_64-linux";
      "zach@howl" = mkHome [./home/zach/howl.nix] "aarch64-linux";
      "zach@laptop-gb" = mkHome [./home/zach/laptop-gb.nix] "x86_64-linux";
      "zach@noface" = mkHome [./home/zach/noface.nix] "x86_64-linux";
    };
  };
}
