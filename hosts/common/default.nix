{ pkgs, globals, ... }:

{
  imports = [
    ./configuration.nix
    ./packages.nix
  ];
}