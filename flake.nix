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
        laptop = nixpkgs.lib.nixosSystem {
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
                type = "laptop";
                kb = "us";
                inherit niri-float-sticky;
              };
              home-manager.users."fantomitechno" = import ./home;
            }
            minegrub-theme.nixosModules.default
          ];
        };
        desktop = nixpkgs.lib.nixosSystem {
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
                type = "desktop";
                kb = "fr";
                inherit niri-float-sticky;
              };
              home-manager.users."fantomitechno" = import ./home;
            }
          ];
        };
        msi = nixpkgs.lib.nixosSystem {
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
                type = "laptop";
                kb = "fr";
                inherit niri-float-sticky;
              };
              home-manager.users."fantomitechno" = import ./home;
            }
          ];
        };
      };
    };
}
