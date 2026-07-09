{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Internship
    firefox
    teams-for-linux

    kdePackages.krdc
  ];
}
