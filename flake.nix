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
      globals = {
        UserName = "fantomitechno";
        HostName = "fantomitechno-nixos";
        GitName = "Simon R. - fantomitechno";
        GitEmail = "me@fantomitechno.dev";
      };

    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit globals; };
          modules = [
            ./hosts/laptop/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit globals; };
              home-manager.users.${globals.UserName} = import ./home/home.nix;
            }
            minegrub-theme.nixosModules.default
          ];
        };
        msi = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit globals; };
          modules = [
            ./hosts/msi/configuration.nix
            ./hosts/common
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit globals; };
              home-manager.users.${globals.UserName} = import ./home/home.nix;
            }
            minegrub-theme.nixosModules.default
          ];
        };
      };
    };
}
