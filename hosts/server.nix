{ hostname, ... }: {
  imports = builtins.map (i: ../modules/${i}) ([
    "cli-apps"
    "fastfetch"
    "git"
    "fail2ban.nix"
    "ssh.nix"
  ]);

  networking = {
    hosts = {
      "172.16.20.10" = [
        "s3.fantom.internal"
      ];
    };

    hostName = "${hostname}";
  };

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";
}
