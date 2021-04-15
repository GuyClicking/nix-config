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
  };

  outputs = { self, nixpkgs, home-manager, neovim, ... }@inputs:
    let
      overlays = [
        neovim.overlay
      ];
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
            home-manager.users.benjamin = import ./home/home.nix;
          }
        ];
      };
      apps.x86_64-linux.home = {
        type = "app";
        program = "${self.home.activationPackage}/activate";
      };
      home = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/benjamin";
        username = "benjamin";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = overlays;
          imports = [
            ./home/home.nix
          ];
        };
      };
    };
}
