{ pkgs, ... }:
{
  home-manager.users."fantomitechno" =
    {
      ...
    }:
    {
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
      };
    };
}
