{
  config,
  pkgs,
  globals,
  ...
}:
let
  dotfileFolder = "${config.home.homeDirectory}/dotfiles";
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
  xdg.configFile."udiskie/config.yml".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/udiskie.yml";
  
  home.file.".ssh/config".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/ssh_config";


  
  xdg.configFile."mimeapps.list".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/mime.list";
}
