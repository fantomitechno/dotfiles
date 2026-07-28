{ lib, pkgs, ... }: {
  services = {
    openssh = {
      enable = lib.mkDefault true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "fantomitechno" ];
        MaxAuthTries = 3;
        PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
      };
      ports = [ 22 ];
    };

    fail2ban = {
      enable = true;
      maxretry = 5;
      ignoreIP = [
        "172.16.0.0/16"
      ];

      bantime = "24h"; # Ban IPs for one day on the first ban
      bantime-increment = {
        enable = true; # Enable increment of bantime after each violation
        multipliers = "1 2 4 8 16 32 64";
        maxtime = "168h"; # Do not ban for more than 1 week
        overalljails = true; # Calculate the bantime based on all the violations
      };

      extraPackages = [ pkgs.ipset ];
      banaction = "iptables-ipset-proto6-allports"; # ban on all port; v4 and v6
    };
  };
}
