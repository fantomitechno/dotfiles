{ flakes, ... }: {
  imports = [
    flakes.inputs.tangled.nixosModules.knot
  ];

  services = {
    tangled.knot = {
      enable = true;
      gitUser = "git";
      stateDir = "/var/lib/tangled-knot";
      repo.scanPath = "/nas/knot/repos";
      motd = "mreoow";
      server = {
        listenAddr = "127.0.0.1:4000";
        hostname = "knot.fantomitechno.dev";
        owner = "did:plc:q2leouakch2kg4ruldreunip";
      };
    };

    openssh = {
      settings.AllowUsers = [ "git" ];
      settings.AllowGroups = [ "git" ];
    };
  };
}
