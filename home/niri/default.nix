{ config, ... }:
let
  dotfileFolder = "${config.home.homeDirectory}/dotfiles";
  niriFolder = "${dotfileFolder}/home/niri";
in
{
  xdg.configFile."niri".source = config.lib.file.mkOutOfStoreSymlink "${niriFolder}/config";
  xdg.configFile."swaylock/config".source =
    config.lib.file.mkOutOfStoreSymlink "${niriFolder}/swaylock.conf";
  home.file.".local/bin/nws.sh".source = config.lib.file.mkOutOfStoreSymlink "${niriFolder}/nws.sh";
}
