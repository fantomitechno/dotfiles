{
  description = "NixOS configuration for the Fox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    niri-float-sticky.url = "github:probeldev/niri-float-sticky";
    niri-float-sticky.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      minegrub-theme,
      millennium,
      niri-float-sticky,
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
              nixpkgs.overlays = [ millennium.overlays.default ];
            }
            ./hosts/laptop/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit niri-float-sticky;
                hostname = "laptop";
              };
              home-manager.users."fantomitechno" = import ./home;
            }
            minegrub-theme.nixosModules.default
          ];
        };
        fantomitechno-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = [ millennium.overlays.default ];
            }
            ./hosts/desktop/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit niri-float-sticky;
                hostname = "desktop";
              };
              home-manager.users."fantomitechno" = import ./home;
            }
          ];
        };
        fantomitechno-msi = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = [ millennium.overlays.default ];
            }
            ./hosts/msi/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit niri-float-sticky;
                hostname = "msi";
              };
              home-manager.users."fantomitechno" = import ./home;
            }
          ];
        };
      };
    };
}
