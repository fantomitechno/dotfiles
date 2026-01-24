{
  config,
  pkgs,
  globals,
  ...
}:
let
  dotfileFolder = "${config.home.homeDirectory}/dotfile";
  configFolder = "${dotfileFolder}/home/config";
in
{
  xdg.configFile."waypaper/config.ini".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/waypaper.ini";
  home.file."Pictures/Wallpaper".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/wallpapers";
  xdg.configFile."VSCodium/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/codium/settings.json";
  xdg.configFile."VSCodium/User/keybindings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/codium/keybindings.json";
  
  
}
