{ pkgs, ... }:
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
    antimicrox
    archipelago
    (celestegame.override {
      withEverest = true;
      writableDir = "${celesteFolder}/writable";
      gameDir = "${celesteFolder}/game";
    })
    gale
    lumafly
    mumble
    mangohud
    (olympus.override { finderHints = "${celesteFolder}/game"; })
    osu-lazer-bin
    pandora-launcher
    parsec-bin
    prismlauncher
    protonup-rs
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
