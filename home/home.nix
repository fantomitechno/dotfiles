{
  pkgs,
  globals,
  ...
}:

{
  home.stateVersion = "25.05";
  home.homeDirectory = "/home/${globals.UserName}";

  imports = [
    ./config
    ./fastfetch
    ./niri
    ./waybar

    ./clipboard.nix
    ./codium.nix
    ./git.nix
    ./terminal.nix
    ./wofi.nix
    ./zsh.nix
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
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
  };
  qt = {
    enable = true;
    style.name = "adwaita";
  };
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Amber";
    size = 12;
  };

  programs = {
    home-manager.enable = true;
    go.enable = true;
    zsh.enable = true;
    zoxide.enable = true;
    obs-studio.enable = true;
    obs-studio.plugins = [ pkgs.obs-studio-plugins.wlrobs ];

  };

  services.swww.enable = true;
  services.swaync.enable = true;

}
