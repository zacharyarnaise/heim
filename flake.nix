{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs = {url = "github:nixos/nixpkgs/nixos-unstable";};
    nixos-hardware = {url = "github:nixos/nixos-hardware/master";};

    home-manager = {
      url = "github:nix-community/home-manager";
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
  in {
    # Reusable NixOS and home-manager modules
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    # Custom packages available through 'nix build', 'nix shell', etc.
    packages = forSupportedSystems (pkgs: import ./pkgs {inherit pkgs;});
    # Formatter available through 'nix fmt'
    formatter = forSupportedSystems (pkgs: pkgs.alejandra);

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#hostname'
    nixosConfigurations = {
      calcifer = nixpkgs.lib.nixosSystem {
        modules = [./hosts/calcifer];
        specialArgs = {inherit inputs outputs;};
      };

      laptop-gb = nixpkgs.lib.nixosSystem {
        modules = [./hosts/laptop-gb];
        specialArgs = {inherit inputs outputs;};
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
