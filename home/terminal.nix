{ pkgs, ... }:
{
  programs = {
    kitty = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        grep = "grep --color=auto";
        cat = "bat";
        df = "duf";
        ssh = "TERM=xterm-256color kitten ssh";
        lt = "tree --gitignore";
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
      ];
    };
  };

}
