{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # network :3
    arp-scan
    nmap
    openvpn
    proton-vpn
    python314Packages.shodan
    tailscale
    wireguard-tools
    wireshark
  ];

  services = {
    # Network
    tailscale.enable = true;
  };

  programs = {
    # Network
    wireshark.enable = true;
  };
}
