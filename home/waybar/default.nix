{ config, pkgs, lib, ... }:
let
	dotfileFolder = "${config.home.homeDirectory}/dotfile";
	waybarFolder = "${dotfileFolder}/home/waybar";
in {
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "${waybarFolder}/config";
}
