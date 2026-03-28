{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      detachhead.basedpyright
      esbenp.prettier-vscode
      jnoortheen.nix-ide
      leonardssh.vscord
      # minecraftcommands.syntax-mcfunction
      # misodee.vscode-nbt
      ms-dotnettools.vscode-dotnet-runtime
      ms-dotnettools.csharp
      ms-dotnettools.csdevkit
      ms-python.python
      ms-python.debugpy
      prisma.prisma
      # qwtel.sqlite-viewer
      seatonjiang.gitmoji-vscode
      # spgoding.datapack-language-server
      # superant.mc-dp-icons
      svelte.svelte-vscode
    ];
  };
}
