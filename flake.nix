{
  description = "My NixOS configurations";

  # nix options specific to this flake
  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
    show-trace = true;

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

    genRevision = with builtins; {
      gitHash = self.rev or self.dirtyRev;
      gitDate =
        if self.sourceInfo ? lastModifiedDate
        then concatStringsSep "-" (match "(.{4})(.{2})(.{2}).*" self.sourceInfo.lastModifiedDate)
        else "unknown-date";

      system.configurationRevision = gitHash;
      system.nixos.label =
        if self ? rev
        then "${gitDate}_${substring 0 7 gitHash}"
        else "dirty_${gitDate}_${substring 0 7 gitHash}";
    };
  in {
    # Custom packages available through 'nix build', 'nix shell', etc.
    packages = forSupportedSystems (pkgs: import ./pkgs {inherit pkgs;});
    # nix fmt formatter
    formatter = forSupportedSystems (pkgs: pkgs.alejandra);

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
