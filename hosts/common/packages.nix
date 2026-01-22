{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # terminal stuff
    kitty
    fastfetch
    btop
    starship
    wget
    curl
    bat
    git
    glib
    lazygit
    lazydocker
    go
    fastfetch
    docker
    docker-compose
    gcc
    gnumake
    duf

    # media
    ffmpeg
    playerctl
    obs-studio
    tidal-hifi
    vlc

    # DE stuff
    waybar-mpris
    waypaper
    swww
    waybar
    networkmanagerapplet
    swaylock-effects
    swayidle
    swaynotificationcenter
    wl-clipboard-rs
    wlogout
    wofi
    adw-gtk3
    papirus-icon-theme
    ly
    grub2
    xwayland
    xwayland-satellite
    jq
    xdg-desktop-portal-wlr

    # apps
    vesktop
    nautilus
    steam
    bitwarden-desktop
    proton-pass

    # network :3
    openvpn
    tailscale

    # idk I'll find out later
    nh
    gopls
    musl
    pavucontrol
    polkit
    nixfmt
  ];

  xdg.portal.wlr.enable = true;

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
    ];
  };

  services = {
    displayManager.enable = true;
    displayManager.ly.enable = true;
    # services.openssh.enable = true;
    tailscale.enable = true;
  };

  programs = {
    nix-ld.enable = true;
    niri.enable = true;
    xwayland.enable = true;
    zsh.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
  };
}
