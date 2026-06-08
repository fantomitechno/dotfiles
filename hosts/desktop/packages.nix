{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nantarena
    mongodb-compass

    # Video editing
    kdePackages.kdenlive
    audacity
  ];
}
