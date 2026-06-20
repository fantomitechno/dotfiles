{ ... }:

{
  imports = [
    ./configuration.nix
    ./packages.nix
    ./battery-notify.nix
  ];

  home-manager.users."fantomitechno" = import ../../home;
}
