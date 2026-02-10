{ config, type, ... }:
let
  dotfileFolder = "${config.home.homeDirectory}/dotfiles";
  niriFolder = "${dotfileFolder}/home/niri";
in
{
  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${niriFolder}/config/${type}.kdl";
  xdg.configFile."niri/common".source =
    config.lib.file.mkOutOfStoreSymlink "${niriFolder}/config/common";

  xdg.configFile."swaylock/config".source =
    config.lib.file.mkOutOfStoreSymlink "${niriFolder}/swaylock.conf";
  home.file.".local/bin/nws.sh".source = config.lib.file.mkOutOfStoreSymlink "${niriFolder}/nws.sh";
}
