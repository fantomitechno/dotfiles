{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jetbrains.idea-oss
  ];

  programs = {
    java = {
      enable = true;
      package = pkgs.jdk25;
    };
  };
}
