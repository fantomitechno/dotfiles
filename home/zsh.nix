{ pkgs, ... }:
{
  programs = {
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
            owner = "MichaelAquilina";
            repo = "zsh-autoswitch-virtualenv";
            rev = "3.9.0";
            sha256 = "sha256-j2YX+OcYbvS2G/KUNzcWbJepm9bZlegp1r8ZjcY6Nnw";
          };
        }
      ];
    };
  };
}
