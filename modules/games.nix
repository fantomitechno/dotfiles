{ pkgs, dotfileFolder, ... }:
let
  celesteFolder = "/home/fantomitechno/Games/Celeste2";
in
{
  programs = {
    # Gayming
    steam = {
      enable = true;
      # package = pkgs.millennium-steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    # GameMode is a daemon/lib combo for Linux that allows games to request a set of optimisations be temporarily applied to the host OS and/or a game process.
    gamemode.enable = true;
  };

  environment.systemPackages = with pkgs; [
    antimicrox # Controller mapping
    archipelago # Randomizer
    gale # Peak modding
    lumafly # HK Modding
    mumble # Voice Chat
    mangohud # Steam HUD
    olympus # Celeste Modding
    osu-lazer-bin
    pandora-launcher # Minecraft launcher
    parsec-bin # Remote play
    prismlauncher # Minecraft launcher -1
    protonup-rs # Steam wine

    # Sandboxing for Pandora launcher
    bubblewrap
    xdg-dbus-proxy
  ];

  home-manager.users."fantomitechno" =
    {
      ...
    }:
    {
      programs = {
        lutris.enable = true;
      };
    };
}
