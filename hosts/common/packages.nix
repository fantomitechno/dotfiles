{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # low level stuff that is annoying :c
    musl
    polkit

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
    tree
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
    nil
    nixfmt

    # media
    ffmpeg
    playerctl
    tidal-hifi
    vlc

    # DE stuff
    adw-gtk3
    awww
    cliphist
    grub2
    jq
    ly
    networkmanagerapplet
    papirus-icon-theme
    pavucontrol
    sunsetr
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

    # apps
    archipelago
    bitwarden-desktop
    file-roller
    gnome-calculator
    libreoffice
    loupe
    lumafly
    mumble
    nautilus
    olympus
    pinta
    proton-pass
    protonup-rs
    signal-desktop
    tetrio-desktop
    vesktop

    # network :3
    openvpn
    proton-vpn
    tailscale
    wireguard-tools
    wireshark
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
    # DM
    displayManager.enable = true;
    displayManager.ly.enable = true;
    # services.openssh.enable = true;

    # Network
    tailscale.enable = true;

    # Bluetooth
    blueman.enable = true;

    # Auto mount usb keys
    udisks2.enable = true;
  };

  programs = {
    # WM
    niri.enable = true;
    xwayland.enable = true;

    # Nix but looks like linux
    nix-ld.enable = true;

    # My terminal uwu
    zsh.enable = true;

    # Gayming
    steam = {
      enable = true;
      package = pkgs.millennium-steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    # GameMode is a daemon/lib combo for Linux that allows games to request a set of optimisations be temporarily applied to the host OS and/or a game process.
    gamemode.enable = true;

    # PDF Viewer
    evince.enable = true;

    # Network
    wireshark.enable = true;
  };
}
