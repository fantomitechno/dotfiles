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

    activate-linux = {
      url = "github:Kljunas2/activate-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix4vscode,
      ...
    }:
    let
      system = "x86_64-linux";

      commonSystem =
        hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit hostname;
            dotfileFolder = "/home/fantomitechno/dotfiles";
            flakes = self;
          };
          modules = [
            {
              nixpkgs.overlays = [ nix4vscode.overlays.default ];
            }
            ./hosts
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit hostname;
                  dotfileFolder = "/home/fantomitechno/dotfiles";
                  flakes = self;
                };

                users."fantomitechno" = { lib, ... }: {
                  home.homeDirectory = "/home/fantomitechno";
                  home.stateVersion = "26.05";
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        fantomitechno-laptop = commonSystem "laptop";
        fantomitechno-desktop = commonSystem "desktop";
        fantomitechno-msi = commonSystem "msi";
        conseil = commonSystem "conseil";
      };
    };
}
