{ pkgs, ... }: {
  # Enable Plasma
  services = {
    desktopManager.plasma6.enable = true;

    # Optionally enable xserver
    xserver.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    aurorae
    plasma-browser-integration
    konsole
    ark
    elisa
    gwenview
    kwin-x11
    qrca
    okular
    kate
    ktexteditor
    khelpcenter
    dolphin
    baloo-widgets
    dolphin-plugins
    spectacle
    krdp
  ];

  security = {
    # If enabled, pam_wallet will attempt to automatically unlock the user’s default KDE wallet upon login.
    # If the user has no wallet named “kdewallet”, or the login password does not match their wallet password,
    # KDE will prompt separately after login.
    pam = {
      services = {
        "fantomitechno" = {
          kwallet = {
            enable = true;
            forceRun = true;
          };
        };
      };
    };
  };

  home-manager.users."fantomitechno" =
    {
      config,
      pkgs,
      dotfileFolder,
      ...
    }:
    let
      kdeFolder = "${dotfileFolder}/modules/kde/config";
    in
    {
      home = {
        pointerCursor = {
          enable = true;
          gtk.enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Amber";
          size = 12;
        };
      };
      xdg.configFile."kactivitymanagerdstatsrc".source =
        config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kactivitymanagerdstatsrc";
      xdg.configFile."kactivitymanagerdrc".source =
        config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kactivitymanagerdrc";
      xdg.configFile."kcminputrc".source = config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kcminputrc";
      xdg.configFile."kconf_updaterc".source =
        config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kconf_updaterc";
      xdg.configFile."kded5rc".source = config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kded5rc";
      xdg.configFile."kdeglobals".source = config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kdeglobals";
      xdg.configFile."kglobalshortcutsrc".source =
        config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kglobalshortcutsrc";
      xdg.configFile."kmenueditrc".source =
        config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kmenueditrc";
      xdg.configFile."ksmserverrc".source =
        config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/ksmserverrc";
      xdg.configFile."kwalletrc".source = config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kwalletrc";
      xdg.configFile."kwinoutputconfigjson".source =
        config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kwinoutputconfigjson";
      xdg.configFile."kwinrc".source = config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kwinrc";
      xdg.configFile."kwinrulesrc".source =
        config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kwinrulesrc";
      xdg.configFile."kxkbrc".source = config.lib.file.mkOutOfStoreSymlink "${kdeFolder}/kxkbrc";
    };
}
