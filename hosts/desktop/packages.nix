{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nantarena
    mongodb-compass

    # Games
    prismlauncher

    # Video editing
    kdePackages.kdenlive
    audacity
  ];
}
