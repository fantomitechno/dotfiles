{ ... }:
{
  home-manager.users."fantomitechno" =
    {
      config,
      pkgs,
      dotfileFolder,
      ...
    }:
    let
      codiumFolder = "${dotfileFolder}/modules/codium";
    in
    {
      programs.vscodium = {
        enable = true;
        package = pkgs.vscodium;
        profiles.default.extensions =
          pkgs.nix4vscode.forOpenVsx [
            "catppuccin.catppuccin-vsc"
            "catppuccin.catppuccin-vsc-icons"
            "DigitalBrainstem.javascript-ejs-support"
            "charliermarsh.ruff"
            "detachhead.basedpyright"
            "esbenp.prettier-vscode"
            "jeanp413.open-remote-ssh"
            "jnoortheen.nix-ide"
            "leonardssh.vscord"
            "minecraftcommands.syntax-mcfunction"
            "misodee.vscode-nbt"
            "prisma.prisma"
            "qwtel.sqlite-viewer"
            "rvest.vs-code-prettier-eslint"
            "seatonjiang.gitmoji-vscode"
            "spgoding.datapack-language-server"
            "superant.mc-dp-icons"
            "svelte.svelte-vscode"
          ]
          ++ pkgs.nix4vscode.forVscode [
            "ms-dotnettools.vscode-dotnet-runtime"
            "ms-dotnettools.csharp"
            "ms-dotnettools.csdevkit"
            "ms-python.python"
            "ms-python.debugpy"
          ];
      };

      xdg.configFile."VSCodium/User/settings.json".source =
        config.lib.file.mkOutOfStoreSymlink "${codiumFolder}/settings.json";
      xdg.configFile."VSCodium/User/keybindings.json".source =
        config.lib.file.mkOutOfStoreSymlink "${codiumFolder}/keybindings.json";
    };
}
