{
  description = "My NixOS configurations";
  nixConfig = {
    extra-substituters = ["https://nix-community.cachix.org"];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    impermanence.url = "github:nix-community/impermanence";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    sops-nix,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Helper function to generate an attribute set for each supported system
    forSupportedSystems = f:
      nixpkgs.lib.genAttrs ["x86_64-linux"] (system: f system);

    # Nixpkgs instantiated for supported systems
    nixpkgsFor = forSupportedSystems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });

    # Format a date string as YYYY-MM-DD
    formatDate = date:
      with builtins;
        concatStringsSep "-" (match "(.{4})(.{2})(.{2}).*" date);

    # Enrich system revision and label with Git information
    genSystemLabel = let
      hash = self.rev or self.dirtyRev;
      shortHash = builtins.substring 0 7 hash;
      date =
        if self.sourceInfo ? lastModifiedDate
        then formatDate self.sourceInfo.lastModifiedDate
        else "unknown-date";
    in {
      system.configurationRevision = hash;
      system.nixos.label =
        if self.rev == null
        then "dirty_"
        else "" + "${date}_${shortHash}";
    };
  in {
    # Custom packages available through 'nix build', 'nix shell', etc.
    packages = forSupportedSystems (pkgs: import ./pkgs {inherit pkgs;});
    # nix fmt formatter
    formatter = forSupportedSystems (pkgs: pkgs.alejandra);
    # Flake output attributes for 'nix develop'
    devShells = forSupportedSystems (pkgs: import ./shell.nix {inherit pkgs;});

    # Reusable NixOS and home-manager modules
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    # Custom packages and modifications, exported as overlays
    overlays = import ./overlays;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#hostname'
    nixosConfigurations = {
      "calcifer" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/calcifer
          genSystemLabel
        ];
      };

      "laptop-gb" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/laptop-gb
          genSystemLabel
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#username@hostname'
    homeConfigurations = {
      "zach@calcifer" = nixpkgs.lib.homeManagerConfiguration {
        modules = [
          ./home/zach/all
          ./home/zach/calcifer.nix
        ];
        pkgs = nixpkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "zach@laptop-gb" = nixpkgs.lib.homeManagerConfiguration {
        modules = [
          ./home/zach/all
          ./home/zach/laptop-gb.nix
        ];
        pkgs = nixpkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
