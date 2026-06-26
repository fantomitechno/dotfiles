# Homelab

## VLANs

| VID | NAME | PREFIX | ACESS | PERMISSIONS | 
| -- | -- | -- | -- | -- |
| 10 | ADMIN | `172.16.10.0/24` | Ethernet with 802.1X | Internet without restrictions, SSH to servers |
| 20 | SERVERS | `172.16.20.0/24` | specific ethernet ports | Internet without restrictions | 
| 100 | GUEST | `172.16.100.0/24` | Ethernet and WiFi | Restricted to HTTP and HTTPS |

## IPs

| hostname | address(es) |
| :-- | -- |
| OpnSense-DeLoreane | `172.16.10.1/24`, `172.16.20.1/24`, `172.16.100.1/24` |
| SG500X-Argo3 | `172.16.10.2/24`, `172.16.20.2/24`, `172.16.100.2/24` |
| conseil | `172.16.20.10/24` |
| fant0mib0t | `172.16.20.20/24` |