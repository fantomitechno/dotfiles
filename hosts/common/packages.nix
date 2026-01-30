{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # terminal stuff
    bat
    btop
    curl
    dig
    duf
    fastfetch
    glib
    inetutils
    kitty
    python3
    starship
    unzip
    wget
    yt-dlp
    zip

    # programing
    docker
    docker-compose
    gcc
    git
    gitmoji-cli
    go
    gopls
    gnumake
    lazydocker
    lazygit

    # media
    ffmpeg
    obs-studio
    playerctl
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
    pavucontrol

    # apps
    bitwarden-desktop
    nautilus
    olympus
    proton-pass
    signal-desktop
    steam
    vesktop

    # network :3
    openvpn
    tailscale

    # idk I'll find out later
    musl
    nixfmt
    polkit
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
    blueman.enable = true;
    udisks2.enable = true;
  };

  programs = {
    niri.enable = true;
    nix-ld.enable = true;
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
