{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      grep = "grep --color=auto";
      cat = "bat";
      df = "duf";
    };

    initContent = ''
      export PATH="$HOME/.local/bin:$PATH"
      export GOPATH=$HOME/go
      export PATH="$PATH:$HOME/go/bin"
      eval "$(starship init zsh)"
      eval "fastfetch"
    '';
  };
}
