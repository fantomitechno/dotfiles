{ pkgs, ... }:

{
  networking = {
    nameservers = [
      "80.67.169.12" # FDN
      "86.54.11.100" # Unfiltred DNS4EU
    ];
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users."fantomitechno" = {
    isNormalUser = true;
    description = "Simon Renoux";
    extraGroups = [
      "wheel"
      "podman"
      "dialout"
    ];
    shell = pkgs.zsh;
  };

  security.polkit.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  home-manager.users."fantomitechno" = { lib, ... }: {
    home.homeDirectory = "/home/fantomitechno";
  };

  security.pki.caCertificateBlacklist = [
    # "Comodo AAA Services root"
    # "emSign ECC Root CA - G3"
  ];
}
