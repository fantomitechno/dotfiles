{ ... }:
{

  home-manager.users."fantomitechno" =
    {
      config,
      dotfileFolder,
      ...
    }:
    {
      xdg.configFile."waybar".source =
        config.lib.file.mkOutOfStoreSymlink "${dotfileFolder}/modules/niri-de/waybar/config";
    };
}
