{ ... }: {
  imports = [
    # ./s3.nix
  ];

  services = {
    nfs.server = {
      enable = true;
      statdPort = 4000;
      lockdPort = 4001;
      mountdPort = 4002;
      exports = ''
        /data 172.16.10.0/24(insecure,rw,sync,crossmnt,fsid=0) 172.16.20.0/24(insecure,rw,sync,crossmnt,fsid=0) 172.16.30.0/24(insecure,rw,sync,crossmnt,fsid=0)
      '';
    };
  };

  networking.firewall = {
    enable = true;
    # for NFSv3; view with `rpcinfo -p`
    allowedTCPPorts = [
      111
      2049
      4000
      4001
      4002
    ];
    allowedUDPPorts = [
      111
      2049
      4000
      4001
      4002
    ];
  };

  users.users = {
    "forgejo" = {
      isSystemUser = true;
      uid = 990;
      group = "forgejo";
    };
    "cryptpad" = {
      isSystemUser = true;
      uid = 4001;
      group = "cryptpad";
    };
  };
  users.groups = {
    "forgejo" = {
      gid = 990;
    };
    "cryptpad" = {
      gid = 4001;
    };
  };
}
