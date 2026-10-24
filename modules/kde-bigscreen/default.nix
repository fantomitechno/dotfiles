{ pkgs, pkg-unstable, ... }: {

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "breeze";
      wayland.enable = true;
      settings = {
        Autologin = {
          Session = "plasma-bigscreen-wayland";
          User = "fantomitechno";
        };
      };
    };
    displayManager.sessionPackages = [
      pkg-unstable.kdePackages.plasma-bigscreen
    ];
  };

  xdg.portal.configPackages = [ pkg-unstable.kdePackages.plasma-bigscreen ];
  environment.systemPackages = [
    pkg-unstable.kdePackages.plasma-bigscreen
    pkgs.libcec
    pkgs.v4l-utils
  ];
}
