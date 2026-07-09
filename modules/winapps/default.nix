{ flakes, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    flakes.inputs.winapps.packages."${system}".winapps
    flakes.inputs.winapps.packages."${system}".winapps-launcher # optional
  ];

  home-manager.users."fantomitechno" =
    {
      config,
      dotfileFolder,
      ...
    }:
    {
      xdg.configFile."winapps/winapps.conf".source =
        config.lib.file.mkOutOfStoreSymlink "${dotfileFolder}/modules/winapps/winapps.conf";
    };
}
