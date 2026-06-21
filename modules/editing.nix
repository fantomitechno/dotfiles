{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Video editing
    kdePackages.kdenlive
    audacity
  ];
}
