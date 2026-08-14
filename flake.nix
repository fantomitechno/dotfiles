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

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homelab inputs

    copyparty = {
      url = "github:9001/copyparty?tag=v1.20.16";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tangled = {
      url = "git+https://tangled.org/tangled.org/core?ref=refs/tags/v1.15.0-alpha";
      inputs.nixpkgs.follows = "nixpkgs";
      # Disable useless monorepo inputs
      inputs.actor-typeahead-src.follows = "";
      inputs.fenix.follows = "";
      inputs.htmx-src.follows = "";
      inputs.htmx-ws-src.follows = "";
      inputs.ibm-plex-mono-src.follows = "";
      inputs.inter-fonts-src.follows = "";
      inputs.lucide-src.follows = "";
      inputs.mermaid-src.follows = "";
    };

    disko = {
      url = "github:nix-community/disko?tag=v1.20.16";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      dotfileFolder = "/home/fantomitechno/dotfiles";
      flakes = self;

      commonSystem =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit hostname;
            inherit dotfileFolder;
            inherit flakes;
          };
          modules = [
            ./hosts
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit hostname;
                  inherit dotfileFolder;
                  inherit flakes;
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

        # Servers
        Conseil = commonSystem "conseil";
        fant0mib0t = commonSystem "fant0mib0t";

        # Installer
        # nix build --no-link --print-out-paths ".#installer"
        installer = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/installer.nix
          ];
        };

      };
      installer = self.outputs.nixosConfigurations.installer.config.system.build.isoImage;
    };
}
