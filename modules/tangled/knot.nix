{ flakes, ... }: {
  imports = [
    flakes.inputs.tangled.nixosModules.knot-rs
  ];

  services = {
    tangled.knot-rs = {
      enable = true;
      environmentFile = "/var/lib/secrets/knot.env";
      settings = {
        stateDir = "/var/lib/tangled-knot";
        repo.scan_path = "/nas/knot/repos";
        lfs.store_path = "/var/lib/tangled-knot/lfs";
        atproto.plc_directory = "https://plc.directory";
        server = {
          listen_ddr = "127.0.0.1:4000";
          hostname = "knot.fantomitechno.dev";
          admins = ["did:plc:q2leouakch2kg4ruldreunip"];
        };
        contact.email = "knot@fantomitechno.dev";
      };
    };
  };
}
