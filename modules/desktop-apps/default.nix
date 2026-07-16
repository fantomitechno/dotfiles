{ pkgs, ... }:
{
  programs = {
    # PDF Viewer
    evince.enable = true;
  };

  services = {
    # Auto mount usb keys
    udisks2.enable = true;

    # Nautilus fixes
    gvfs.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # media
    ffmpeg
    vlc

    # files
    file-roller
    gimp
    libreoffice
    loupe
    nautilus

    # utilities
    gnome-calculator
    gnome-calendar
    valent

    # browser
    brave
  ];

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      minecraftia
    ];
  };

  home-manager.users."fantomitechno" =
    {
      config,
      pkgs,
      dotfileFolder,
      ...
    }:
    let
      appsFolder = "${dotfileFolder}/modules/desktop-apps";
    in
    {
      xdg.configFile."udiskie/config.yml".source =
        config.lib.file.mkOutOfStoreSymlink "${appsFolder}/udiskie.yml";

      xdg.configFile."mimeapps.list".source =
        config.lib.file.mkOutOfStoreSymlink "${appsFolder}/mime.list";
      xdg.configFile."mimeapps.list".force = true;
    };
}
