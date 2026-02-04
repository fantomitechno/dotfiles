{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    # Games
    prismlauncher
  ];
}