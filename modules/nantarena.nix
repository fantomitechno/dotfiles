{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    # CLI tools
    arp-scan
    nmap
    # Intranet Database
    # mongodb-compass
  ];
}
