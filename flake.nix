{
  description = "fantomitechno's Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # millennium = {
    #   url = "github:SteamClientHomebrew/Millennium/next?dir=packages/nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    niri-float-sticky = {
      url = "github:probeldev/niri-float-sticky";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      # millennium,
      niri-float-sticky,
      nix4vscode,
      ...
    }:
    let
      system = "x86_64-linux";

    in
    {
      nixosConfigurations = {
        fantomitechno-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = [
                # millennium.overlays.default
                nix4vscode.overlays.default
              ];
            }
            ./hosts/laptop/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit niri-float-sticky;
                  hostname = "laptop";
                };
                users."fantomitechno" = import ./home;
              };
            }
          ];
        };
        fantomitechno-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = [
                # millennium.overlays.default
                nix4vscode.overlays.default
              ];
            }
            ./hosts/desktop/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit niri-float-sticky;
                  hostname = "desktop";
                };
                users."fantomitechno" = import ./home;
              };
            }
          ];
        };
        fantomitechno-msi = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = [
                # millennium.overlays.default
                nix4vscode.overlays.default
              ];
            }
            ./hosts/msi/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit niri-float-sticky;
                  hostname = "msi";
                };
                users."fantomitechno" = import ./home;
              };
            }
          ];
        };
      };
    };
}
