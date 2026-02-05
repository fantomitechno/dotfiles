{ config, ... }:
let
  dotfileFolder = "${config.home.homeDirectory}/dotfiles";
  configFolder = "${dotfileFolder}/home/libreoffice";
in
{
  xdg.configFile."libreoffice".source = config.lib.file.mkOutOfStoreSymlink "${configFolder}";
}
