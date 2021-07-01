{
  description = "NixOS + home-manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    vim-plugins-overlay = {
      url = "github:vi-tality/vim-plugins-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    idris2-pkgs = {
      url = "github:claymager/idris2-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim,
    vim-plugins-overlay, idris2-pkgs, ... }@inputs:
    let
      overlays = [
        neovim.overlay
        vim-plugins-overlay.overlay
        #idris2-pkgs.overlay
      ];
      lib = nixpkgs.lib;
      libExtra = import ./lib { inherit lib; };
      homeConfig = path: home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/benjamin";
        username = "benjamin";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = overlays;
          imports = [
            path
          ];
        };
      };
    in
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = overlays;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.benjamin = import ./home/profiles/laptop.nix;
          }
        ];
      };

      packages.x86_64-linux = {
        customize =
          with import nixpkgs { system = "x86_64-linux"; };
          pkgs.callPackage ./customize.nix { };
        };

      defaultApp.x86_64-linux = {
        type = "app";
        program = "${self.packages.x86_64-linux.customize}/bin/customize";
      };
      apps.x86_64-linux = lib.mapAttrs (n: v: {
        type = "app";
        program = "${self.home.${n}.activationPackage}/activate";
      }) self.home;
      #home = homeConfig ./home/home.nix;
      home = libExtra.mapOnDir' ./home/profiles (name: a: lib.nameValuePair (lib.removeSuffix ".nix" name) (homeConfig "${toString ./home/profiles}/${name}"));
    };
}
