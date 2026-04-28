{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nantarena
    mongodb-compass

    # Games
    parsec-bin
    prismlauncher

    # Video editing
    kdePackages.kdenlive
    audacity
  ];
}
