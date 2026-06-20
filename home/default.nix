{
  pkgs,
  niri-float-sticky,
  activate-linux,
  ...
}:

{
  home.stateVersion = "26.05";
  home.homeDirectory = "/home/fantomitechno";

  imports = [
    ./config
    ./fastfetch
    ./libreoffice
    ./niri
    ./waybar

    ./clipboard.nix
    ./codium.nix
    ./git.nix
    ./terminal.nix
    ./wofi.nix
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-enable-primary-paste = false;
    };
  };
  gtk = {
    enable = true;
    theme.name = "Adwaita";

    colorScheme = "dark";

    iconTheme = {
      package = pkgs.yaru-theme;
      name = "Yaru-purple";
    };

    gtk4.theme = null;
  };

  qt = {
    enable = true;
    style.name = "adwaita";
  };

  home = {
    pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Amber";
      size = 12;
    };
    packages = [
      niri-float-sticky.packages.${pkgs.system}.default
      activate-linux.defaultPackage.${pkgs.system}
      pkgs.umu-launcher
    ];
  };

  programs = {
    home-manager.enable = true;
    go.enable = true;
    zsh.enable = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vkcapture
        obs-multi-rtmp
      ];
    };
    lutris.enable = true;
  };

  services = {
    awww.enable = true;
    swaync.enable = true;
  };
}
