{ config, ... }:
let
  dotfileFolder = "${config.home.homeDirectory}/dotfiles";
  fastfetchFolder = "${dotfileFolder}/home/fastfetch";
in
{
  xdg.configFile."fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${fastfetchFolder}/config";
}
