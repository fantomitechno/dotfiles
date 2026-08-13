{ flakes, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    flakes.inputs.winapps.packages."${system}".winapps
    flakes.inputs.winapps.packages."${system}".winapps-launcher
  ];
  
  # set up binary cache
  nix.settings = {
    substituters = [ "https://winapps.cachix.org/" ];
    trusted-public-keys = [ "winapps.cachix.org-1:HI82jWrXZsQRar/PChgIx1unmuEsiQMQq+zt05CD36g=" ];
    trusted-users = [ "fantomitechno" ];
  };

  home-manager.users."fantomitechno" =
    {
      config,
      dotfileFolder,
      ...
    }:
    {
      xdg.configFile."winapps/winapps.conf".source =
        config.lib.file.mkOutOfStoreSymlink "${dotfileFolder}/modules/winapps/winapps.conf";

      programs = {
        zsh = {
          shellAliases = {
            windup = "docker compose -f ${dotfileFolder}/modules/winapps/windows.yaml up -d";
            winddown = "docker compose -f ${dotfileFolder}/modules/winapps/windows.yaml down";
          };
        };
      };
    };
}
