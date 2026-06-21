{ pkgs, ... }:
{
  programs = {
    # Nix but looks like linux
    nix-ld.enable = true;

    # My terminal uwu
    zsh.enable = true; # DO NOT REMOVE EVEN IF IT IS MANAGED BY HOME MANAGER
  };

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
    glib
    inetutils
    starship
    tree
    unzip
    wget
    yt-dlp
    zip

    # programing
    docker
    docker-compose
    cmake
    gcc
    go
    gopls
    gnumake
    lazydocker
    nil
    nixfmt
    python3
    texliveFull
  ];

  home-manager.users."fantomitechno" =
    {
      config,
      pkgs,
      dotfileFolder,
      ...
    }:
    let
      defaultCliFolder = "${dotfileFolder}/modules/default-cli";
    in
    {
      programs = {
        go.enable = true;
        zsh = {
          enable = true;
          enableCompletion = true;

          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;

          shellAliases = {
            grep = "grep --color=auto";
            cat = "bat";
            df = "duf";
            lt = "tree --gitignore";
            rebuild = "cd /home/fantomitechno/dotfiles && sudo nixos-rebuild switch --flake";
          };

          initContent = ''
            export PATH="$HOME/.local/bin:$PATH"
            export GOPATH=$HOME/go
            export PATH="$PATH:$HOME/go/bin"
            eval "$(starship init zsh)"
            eval "fastfetch"
          '';

          oh-my-zsh = {
            enable = true;
            plugins = [
              "docker"
              "docker-compose"
              "history-substring-search"
            ];
          };

          plugins = [
            {
              name = "zsh-nix-shell";
              file = "nix-shell.plugin.zsh";
              src = pkgs.fetchFromGitHub {
                owner = "chisui";
                repo = "zsh-nix-shell";
                rev = "v0.8.0";
                sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
              };
            }
            {
              name = "autoswitch_virtualenv";
              file = "autoswitch_virtualenv.plugin.zsh";
              src = pkgs.fetchFromGitHub {
                owner = "fantomitechno";
                repo = "zsh-autoswitch-virtualenv";
                rev = "f7988cd6f9162b9d342587fedff8e7e69458f711";
                sha256 = "sha256-Ft6B1wvUtQe1jGIdUv4bwEqFS5T7DMaT701aRGw4PB0=";
              };
            }
          ];
        };
      };

      xdg.configFile."starship.toml".source =
        config.lib.file.mkOutOfStoreSymlink "${defaultCliFolder}/starship.toml";

      xdg.configFile."nixpkgs/config.nix".source =
        config.lib.file.mkOutOfStoreSymlink "${defaultCliFolder}/config.nix";

      home.file.".ssh/config".source =
        config.lib.file.mkOutOfStoreSymlink "${defaultCliFolder}/ssh_config";
    };
}
