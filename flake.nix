{
  description = "fantomitechno's Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # millennium = {
    #   url = "github:SteamClientHomebrew/Millennium/next?dir=packages/nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    niri-float-sticky = {
      url = "github:probeldev/niri-float-sticky?tag=v0.0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix4vscode = {
      url = "github:nix-community/nix4vscode?tag=nix4vscode-v0.0.12";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      niri-float-sticky,
      nix4vscode,
      nixos-hardware,
      ...
    }:
    let
      system = "x86_64-linux";

      commonModules = hostname: [
        {
          nixpkgs.overlays = [ nix4vscode.overlays.default ];
        }
        ./hosts/${hostname}/configuration.nix
        ./hosts/common
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit niri-float-sticky;
              hostname = hostname;
            };
            users."fantomitechno" = import ./home;
          };
        }
      ];
    in
    {
      nixosConfigurations = {
        fantomitechno-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = commonModules "laptop" ++ [
            nixos-hardware.nixosModules.framework-13-7040-amd
          ];
        };
        fantomitechno-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = commonModules "desktop";
        };
        fantomitechno-msi = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = commonModules "msi";
        };
      };
    };
}
