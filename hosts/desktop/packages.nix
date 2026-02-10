{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nantarena
    mongodb-compass

    # Games
    prismlauncher

    kdePackages.kdenlive
  ];
}
