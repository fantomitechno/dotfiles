{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Simon R. - fantomitechno";
        email = "me@fantomitechno.dev";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      color.ui = "auto";
    };
  };
}
