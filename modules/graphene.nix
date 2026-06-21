{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Graphene installation process
    androidenv.androidPkgs.platform-tools
  ];
}
