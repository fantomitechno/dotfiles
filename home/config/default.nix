{
  config,
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
  xdg.configFile."mimeapps.list".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/mime.list";

  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/starship.toml";
  xdg.configFile."sunsetr/sunsetr.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/sunsetr.toml";

  xdg.configFile."gitmoji-nodejs/config.json".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/gitmoji.json";

  xdg.configFile."nixpkgs/config.nix".source =
    config.lib.file.mkOutOfStoreSymlink "${configFolder}/config.nix";

  home.file.".ssh/config".source = config.lib.file.mkOutOfStoreSymlink "${configFolder}/ssh_config";
}
