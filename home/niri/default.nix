{
  config,
  hostname,
  ...
}:
let
  dotfileFolder = "${config.home.homeDirectory}/dotfiles";
  niriFolder = "${dotfileFolder}/home/niri";
in
{
  xdg.configFile."niri/configs".source = config.lib.file.mkOutOfStoreSymlink "${niriFolder}/config";
  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${niriFolder}/config/${hostname}.kdl";

  xdg.configFile."swaylock/config".source =
    config.lib.file.mkOutOfStoreSymlink "${niriFolder}/swaylock.conf";
  home.file.".local/bin/nws.sh".source = config.lib.file.mkOutOfStoreSymlink "${niriFolder}/nws.sh";
}
