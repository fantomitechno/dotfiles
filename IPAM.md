# Homelab

## VLANs

| VID | NAME      | PREFIX            | ACESS                   | PERMISSIONS                                   |
| --- | --------- | ----------------- | ----------------------- | --------------------------------------------- |
| 10  | ADMIN     | `172.16.10.0/24`  | Ethernet with 802.1X    | Internet without restrictions, SSH to servers |
| 20  | SERVERS   | `172.16.20.0/24`  | specific Ethernet ports | Internet without restrictions                 |
| 30  | ADMIN VPN | `172.16.30.0/24`  | WireGuard               | Internet without restrictions, SSH to servers |
| 100 | GUEST     | `172.16.100.0/24` | Ethernet and Wi-Fi      | Restricted to HTTP and HTTPS                  |

## IPs

| hostname           | address(es)                                           |
| :----------------- | ----------------------------------------------------- |
| OpnSense-DeLoreane | `172.16.10.1/24`, `172.16.20.1/24`, `172.16.100.1/24` |
| SG500X-Argo3       | `172.16.10.2/24`, `172.16.20.2/24`, `172.16.100.2/24` |
| Conseil            | `172.16.20.10/24`                                     |
| fant0mib0t         | `172.16.20.20/24`                                     |

## Ports & DNS

There are 4 domains that are in use:

- `fantomitechno.dev` and `renoux.dev` that are domains used for public services and are available over the internet
- `fantom.home` which is not a real domain (it only exists via my router), this one is used for local services I, as a user, uses
- `fantom.internal` another local domain, this one used only for communication between different devices

All DNS entries are registered by OpnSense-DeLoreane to point to each machine (using their 172.16.20.0/24 IP if they are on multiple networks).

All public DNS entries are also registered on Cloudflare with a CNAME entry to `rack.fantomitechno.dev` which points to my public IP.

There is a Port forward for all traffic from the Internet to ports 80, 443, 7881, 17230 and the range from 50100 to 50200 of OpnSense-DeLoreane to fant0mib0t.

| Ranges | Description    |
| :----- | :------------- |
| 10XX   | Websites       |
| 20XX   | Communications |
| 30XX   | Metrics        |
| 40XX   | Storages       |

### OpnSense-DeLoreane

| Port Number | Service  | DNS entry            |
| :---------- | :------- | :------------------- |
| 443         | OpnSense | `router.fantom.home` |

### SG500X-Argo3

| Port Number | Service      | DNS entry            |
| :---------- | :----------- | :------------------- |
| 443         | Cisco Web UI | `switch.fantom.home` |

### Conseil

Global DNS: `conseil.fantom.home`

| Port Number      | Service          | DNS entry                                      |
| :--------------- | :--------------- | :--------------------------------------------- |
| 22               | OpenSSH          |                                                |
| 80, 443, 2019    | Caddy            | Port 2019 is the admin API used for Prometheus |
| 3001, 3002       | Prometheus       |                                                |
| 4000, 4001, 4002 | NFS              |                                                |
| 4010             | Garage S3 API    | `s3.fantom.internal`                           |
| 4011             | Garage S3 Web UI | `s3.fantom.home`                               |

### fant0mib0t

Global DNS: `fant0mib0t.fantom.home`

| Port Number      | Service                                 | DNS entry                                            |
| :--------------- | :-------------------------------------- | :--------------------------------------------------- |
| 22               | OpenSSH (used for SSH and Tangled Knot) |                                                      |
| 80, 443, 2019    | Caddy                                   | Port 2019 is the admin API used for Prometheus       |
| 222              | Gitea SSH                               |                                                      |
| 1099             | CelesteNet Admin                        | `cneta.fantomitechno.dev`                            |
| 2000             | Matrix                                  | `matrix.fantomitechno.dev`                           |
| 2001, 2002       | Livekit (Call for Matrix)               | `livekit.fantomitechno.dev`                          |
| 2010             | Tranquill PDS                           | `pds.fantomitechno.dev`                              |
| 2020             | Akkoma                                  | `fedi.fantomitechno.dev`, `fedi.m.fantomitechno.dev` |
| 3000             | Graphana                                | `graph.fantom.home`                                  |
| 3001, 3002, 3003 | Prometheus                              |                                                      |
| 4000             | Tangled Knot                            | `knot.fantomitechno.dev`                             |
| 4005             | Anubis (for Forgejo)                    | `git.fantomitechno.dev`                              |
| 4006             | Forgejo (Behind Anubis)                 |                                                      |
| 4010             | Tangled Spindle                         | `spindle.fantomitechno.dev`                          |
| 4020, 4021       | Cryptpad                                | `drive.renoux.dev`, `drive.s.renoux.dev`             |
| 4025             | Copyparty                               | `files.fantomitechno.dev`                            |
| 4030             | Kiwix                                   | `kiwix.fantomitechno.dev`, `kiwix.renoux.dev`        |
|                  | (redirection to Wikipedia .zim)         | `wikipedia.renoux.dev`                               |
| 4040             | Immich                                  | `photo.renoux.dev`                                   |
| 4050             | Vaultwarden                             | `vault.renoux.dev`                                   |
| 4060             | Paperless                               | `pdf.fantom.home`                                    |
| 4070             | Affine                                  | `notes.fantomitechno.dev`                            |
| 4080             | Jellyfin                                | `jellyfin.fantom.home`                               |
| 4085             | Navidrome                               | `music.fantom.home`                                  |
| 4090             | qBittorrent                             | `torrent.fantom.home`                                |
| 4091             | FlareSolver                             | `flaresolver.fantom.home`                            |
| 4092             | Prowlarr                                | `prowlarr.fantom.home`                               |
| 4093             | Jackett                                 | `jackett.fantom.home`                                |
| 4094             | Sonarr                                  | `sonarr.fantom.home`                                 |
| 4095             | Radarr                                  | `radarr.fantom.home`                                 |
| 4096             | Bazarr                                  | `bazarr.fantom.home`                                 |
| 7881             | Livekit                                 |                                                      |
| 17230            | CelesteNet                              | `cnet.fantomitechno.dev`                             |
| 50100-50200      | Livekit Voice ports                     |                                                      |
