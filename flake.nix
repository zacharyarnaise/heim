{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

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
    impermanence = {
      url = "github:nix-community/impermanence/home-manager-v2";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
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
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay/37f8f092415b444c3bed6eda6bcbee51cee22e5d";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop specific inputs
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    k0s-nix = {
      url = "github:zacharyarnaise/k0s-nix/feat-controller_disable_components";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixarr = {
      url = "github:rasmus-kirk/nixarr";
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

    lib = nixpkgs.lib.extend (
      _: _: (import ./lib {inherit (nixpkgs) lib;}) // home-manager.lib
    );

    supportedSystems = [
      "x86_64-linux"
    ];
    pkgsFor = lib.genAttrs supportedSystems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays =
            builtins.attrValues (import ./overlays {inherit inputs;})
            ++ [inputs.nix-vscode-extensions.overlays.default];
        }
    );
    forEachSystem = f: lib.genAttrs supportedSystems (sys: f pkgsFor.${sys});

    mkNixos = hostname: system: {
      name = hostname;
      value = lib.nixosSystem {
        specialArgs = {
          inherit lib inputs outputs;
          heimRev = self.shortRev or self.dirtyShortRev;
        };
        modules = [
          # Broken by https://github.com/NixOS/nixpkgs/pull/454237
          #nixpkgs.nixosModules.readOnlyPkgs
          {nixpkgs.pkgs = pkgsFor.${system};}

          ./hosts/${hostname}/spec.nix
          ./hosts/${hostname}
        ];
      };
    };

    mkHome = username: hostname: system: {
      name = "${username}@${hostname}";
      value = lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit lib inputs outputs;
          inherit (import ./hosts/${hostname}/spec.nix) hostSpec;
        };
        pkgs = pkgsFor.${system};
        modules = [./home/${username}/${hostname}.nix];
      };
    };
  in {
    # Custom packages to be shared or upstreamed
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    # Nix formatter available through 'nix fmt'
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # -- NixOS configurations --------------------------------------------------
    nixosConfigurations = lib.listToAttrs [
      (mkNixos "calcifer" "x86_64-linux")
      (mkNixos "jiji" "x86_64-linux")
      (mkNixos "kamaji" "x86_64-linux")
      (mkNixos "noface" "x86_64-linux")
      (mkNixos "ponyo" "x86_64-linux")
    ];

    # -- home-manager configurations -------------------------------------------
    homeConfigurations = lib.listToAttrs [
      (mkHome "zach" "calcifer" "x86_64-linux")
      (mkHome "zach" "jiji" "x86_64-linux")
      (mkHome "zach" "kamaji" "x86_64-linux")
      (mkHome "zach" "noface" "x86_64-linux")
      (mkHome "zach" "ponyo" "x86_64-linux")
    ];

    # -- dev shell -------------------------------------------------------------
    checks = forEachSystem (pkgs: import ./checks.nix {inherit inputs pkgs;});
    devShells = forEachSystem (pkgs: {
      default = import ./shell.nix {
        inherit pkgs;
        checks = self.checks.${pkgs.system};
      };
    });
  };
}
