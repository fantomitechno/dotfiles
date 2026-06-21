{ ... }:
{
  home-manager.users."fantomitechno" =
    {
      config,
      dotfileFolder,
      ...
    }:
    {
      home.file."Pictures/Wallpaper".source =
        config.lib.file.mkOutOfStoreSymlink "${dotfileFolder}/modules/wallpapers/images";
    };
}
