{ config, pkgs, globals, ... }:
let
	dotfileFolder = "${config.home.homeDirectory}/dotfile";
	fastfetchFolder = "${dotfileFolder}/home/fastfetch";
in {
	xdg.configFile."fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${fastfetchFolder}/config";
}
