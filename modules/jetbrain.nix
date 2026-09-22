{ pkgs, ... }:
let
  idea = pkgs.jetbrains.idea.overrideAttrs (old: {
    postFixup = (old.postFixup or "") + ''
      wrapProgram $out/bin/idea \
        --suffix LD_LIBRARY_PATH : "${pkgs.libglvnd}/lib"
    '';
  });
in
{
  environment.systemPackages = [
    idea
  ];

  programs = {
    java = {
      enable = true;
      package = pkgs.jdk25;
    };
  };
}
