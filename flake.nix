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
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      type = "git";
      #url = "git+ssh://git@github.com/zacharyarnaise/heim-secrets.git";
      url = "https://github.com/zacharyarnaise/heim-secrets";
      flake = false;
      ref = "main";
      shallow = true;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    ...
  } @ inputs: let
    inherit (self) outputs;

    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    # Nixpkgs instantiated for each supported systems
    nixpkgsFor = nixpkgs.lib.genAttrs supportedSystems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
    # Helper function to generate an attribute set for each supported system
    forSupportedSystems = f:
      nixpkgs.lib.genAttrs supportedSystems (system: f nixpkgsFor.${system});

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
    # Reusable custom modules for NixOS and home-manager
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    # Custom modifications/overrides, exported as overlays
    overlays = import ./overlays;
    # Custom packages, to be shared or upstreamed
    packages = forSupportedSystems (pkgs: import ./pkgs {inherit pkgs;});

    # Nix formatter available through 'nix fmt'
    formatter = forSupportedSystems (pkgs: pkgs.alejandra);
    # Configuration for 'nix develop' shell
    devShells = forSupportedSystems (pkgs: import ./shell.nix {inherit pkgs;});

    # -- NixOS configuration entrypoint ----------------------------------------
    # Available through 'nixos-rebuild --flake .#hostname'
    nixosConfigurations = {
      "calcifer" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/calcifer
          genSystemLabel
        ];
      };

      "howl" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/howl
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

    # -- home-manager configuration entrypoint ---------------------------------
    # Available through 'home-manager --flake .#username@hostname'
    homeConfigurations = {
      "zach@calcifer" = nixpkgs.lib.homeManagerConfiguration {
        modules = [./home/zach/calcifer.nix];
        pkgs = nixpkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "zach@howl" = nixpkgs.lib.homeManagerConfiguration {
        modules = [
          ./home/zach/all
          ./home/zach/howl.nix
        ];
        pkgs = nixpkgsFor.aarch64-linux;
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
