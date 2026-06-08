{ ... }:
{
  imports = [ ./zsh.nix ];
  programs = {
    kitty = {
      enable = true;

      settings = {
        enable_audio_bell = false;
      };
    };
    zsh = {
      shellAliases = {
        ssh = "TERM=xterm-256color kitten ssh";
      };
    };
  };

}
