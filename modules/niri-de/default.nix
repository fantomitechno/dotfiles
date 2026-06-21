{
  hostname,
  pkgs,
  ...
}:
{
  imports = [
    ./clipboard.nix
    ./wofi.nix
    ./waybar

    ../wallpapers
  ];

  programs = {
    # WM
    niri.enable = true;
    xwayland.enable = true;
  };

  services = {
    # Bluetooth
    blueman.enable = true;
  };

  xdg.portal.wlr.enable = true;

  environment.systemPackages = with pkgs; [
    # DE stuff
    adw-gtk3
    awww
    brightnessctl
    cliphist
    grub2
    jq
    ly
    networkmanagerapplet
    papirus-icon-theme
    pavucontrol
    playerctl
    swayidle
    swaylock-effects
    swaynotificationcenter
    udiskie
    waybar
    waybar-mpris
    waypaper
    wl-clipboard
    wl-mirror
    wlogout
    wofi
    xdg-desktop-portal-wlr
    xwayland
    xwayland-satellite
  ];

  home-manager.users."fantomitechno" =
    {
      flakes,
      pkgs,
      config,
      dotfileFolder,
      ...
    }:
    let
      niriFolder = "${dotfileFolder}/modules/niri-de";
    in
    {
      home.packages = [
        flakes.inputs.niri-float-sticky.packages.${pkgs.system}.default
        flakes.inputs.activate-linux.defaultPackage.${pkgs.system}
      ];

      services = {
        awww.enable = true;
        swaync.enable = true;
      };

      xdg.configFile."niri/configs".source = config.lib.file.mkOutOfStoreSymlink "${niriFolder}/config";
      xdg.configFile."niri/config.kdl".source =
        config.lib.file.mkOutOfStoreSymlink "${niriFolder}/config/${hostname}.kdl";

      xdg.configFile."swaylock/config".source =
        config.lib.file.mkOutOfStoreSymlink "${niriFolder}/swaylock.conf";
      home.file.".local/bin/nws.sh".source = config.lib.file.mkOutOfStoreSymlink "${niriFolder}/nws.sh";
      xdg.configFile."waypaper/config.ini".source =
        config.lib.file.mkOutOfStoreSymlink "${niriFolder}/waypaper.ini";
    };
}
