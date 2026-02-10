{
  description = "NixOS configuration for the Fox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      minegrub-theme,
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
            ./hosts/laptop/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                type = "laptop";
              };
              home-manager.users."fantomitechno" = import ./home;
            }
            minegrub-theme.nixosModules.default
          ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/desktop/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                type = "desktop";
              };
              home-manager.users."fantomitechno" = import ./home;
            }
          ];
        };
        msi = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/msi/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                type = "laptop";
              };
              home-manager.users."fantomitechno" = import ./home;
            }
          ];
        };
      };
    };
}
