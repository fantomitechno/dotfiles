{ hostname, ... }: {
  imports = builtins.map (i: ../modules/${i}) ([
    "cli-apps"
    "fastfetch"
    "git"
    "docker.nix"
    "ssh.nix"
  ]);

  networking.hostName = "${hostname}";

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";
}
