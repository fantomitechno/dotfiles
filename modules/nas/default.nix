{ ... }: {
  imports = [
    ./copyparty.nix
    ./s3.nix
  ];

  services.nfs.server = {
    enable = true;
    statdPort = 4000;
    lockdPort = 4001;
    mountdPort = 4002;
    # exports = ''
    #
    # '';
  };
}
