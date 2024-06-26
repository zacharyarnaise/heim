{
  description = "My NixOS configurations";

  nixConfig = {
    # Will be merged with system-level substituters, only affects the flake itself
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    show-trace = true;
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

    # Set of supported systems
    supportedSystems = ["x86_64-linux"];
    # Function to generate an attribute set for each supported system
    forSupportedSystems = f:
      nixpkgs.lib.genAttrs supportedSystems (system: f nixpkgsFor.${system});
    # Attribute set of nixpkgs for each supported system
    nixpkgsFor = forSupportedSystems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });

    # Let NixOS know about the current Git revision
    genRevision = {
      system.configurationRevision = self.rev or self.dirtyRev;
      system.nixos.label =
        self.shortRev
        or nixpkgs.lib.warn "Git tree is dirty" "${self.dirtyShortRev}-dirty";
    };
  in {
    # Custom packages available through 'nix build', 'nix shell', etc.
    packages = forSupportedSystems (pkgs: import ./pkgs {inherit pkgs;});
    # Formatter available through 'nix fmt'
    formatter = forSupportedSystems (pkgs: pkgs.alejandra);

    # Reusable NixOS and home-manager modules
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    # Custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#hostname'
    nixosConfigurations = {
      "calcifer" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/calcifer
          genRevision
        ];
      };

      "laptop-gb" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/laptop-gb
          genRevision
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#username@hostname'
    homeConfigurations = {
      "zach@calcifer" = nixpkgs.lib.homeManagerConfiguration {
        modules = [./home/zach/calcifer.nix];
        pkgs = nixpkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "zach@laptop-gb" = nixpkgs.lib.homeManagerConfiguration {
        modules = [./home/zach/laptop-gb.nix];
        pkgs = nixpkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
