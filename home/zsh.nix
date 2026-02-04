{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      grep = "grep --color=auto";
      cat = "bat";
      df = "duf";
      ssh = "TERM=xterm-256color kitten ssh";
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
  };
}
