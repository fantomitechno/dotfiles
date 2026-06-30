# Homelab

## VLANs

| VID | NAME    | PREFIX            | ACESS                   | PERMISSIONS                                   |
| --- | ------- | ----------------- | ----------------------- | --------------------------------------------- |
| 10  | ADMIN   | `172.16.10.0/24`  | Ethernet with 802.1X    | Internet without restrictions, SSH to servers |
| 20  | SERVERS | `172.16.20.0/24`  | specific ethernet ports | Internet without restrictions                 |
| 100 | GUEST   | `172.16.100.0/24` | Ethernet and WiFi       | Restricted to HTTP and HTTPS                  |

## IPs

| hostname           | address(es)                                           |
| :----------------- | ----------------------------------------------------- |
| OpnSense-DeLoreane | `172.16.10.1/24`, `172.16.20.1/24`, `172.16.100.1/24` |
| SG500X-Argo3       | `172.16.10.2/24`, `172.16.20.2/24`, `172.16.100.2/24` |
| Conseil            | `172.16.20.10/24`                                     |
| fant0mib0t         | `172.16.20.20/24`                                     |

## Ports & DNS

There is 4 domains that are in use:

- `fantomitechno.dev` and `renoux.dev` that are domains used for public services and are available over the internet
- `fantom.home` which is not a real domain (it only exists via my router), this one is used for local services I, as a user, uses
- `fantom.internal` another local domain, this one used only for communication between different devices

All DNS entries are registered by OpnSense-DeLoreane to point to each machines (using their 172.16.20.0/24 IP if they are on multiple networks).

All public DNS entries are also registered on Cloudflare with a CNAME entry to `rack.fantomitechno.dev` which points to my public IP.

| Ranges | Description    |
| :----- | :------------- |
| 10XX   | Websites       |
| 20XX   | Communications |
| 40XX   | Storages       |

### OpnSense-DeLoreane

| Port Number | Service  | DNS entry            |
| :---------- | :------- | :------------------- |
| 80, 443     | Caddy    |                      |
| 1000        | OpnSense | `router.fantom.home` |

### SG500X-Argo3

| Port Number | Service      | DNS entry            |
| :---------- | :----------- | :------------------- |
| 443         | Cisco Web UI | `switch.fantom.home` |

### Conseil

Global DNS: `conseil.renoux.dev`

| Port Number      | Service          | DNS entry                 |
| :--------------- | :--------------- | :------------------------ |
| 22               | OpenSSH          |                           |
| 80, 443          | Caddy            |                           |
| 4000, 4001, 4002 | NFS              |                           |
| 4010             | Garage S3 API    | `s3.fantom.internal`      |
| 4011             | Garage S3 Web UI | `s3.fantom.home`          |
| 4020             | Copyparty        | `files.fantomitechno.dev` |

### fant0mib0t

Global DNS: `fant0mib0t.renoux.dev`

| Port Number | Service                                 | DNS entry                                     |
| :---------- | :-------------------------------------- | :-------------------------------------------- |
| 22          | OpenSSH (used for SSH and Tangled Knot) |                                               |
| 80, 443     | Caddy                                   |                                               |
| 222         | Gitea SSH                               |                                               |
| 2000        | Matrix                                  | `matrix.fantomitechno.dev`                    |
| 2010        | Tranquill PDS                           | `pds.fantomitechno.dev`                       |
| 2020,2021   | Mastodon                                | `mastodon.fantomitechno.dev`                  |
| 4000        | Tangled Knot                            | `knot.fantomitechno.dev`                      |
| 4005        | Gitea                                   | `git.fantomitechno.dev`                       |
| 4010        | Tangled Spindle                         | `spindle.fantomitechno.dev`                   |
| 4020, 4021  | Cryptpad                                | `drive.renoux.dev`, `drive.s.renoux.dev`      |
| 4030        | Kiwix                                   | `kiwix.fantomitechno.dev`, `kiwix.renoux.dev` |
|             | (redirection to Wikipedia .zim)         | `wikipedia.renoux.dev`                        |
| 4040        | Immich                                  | `photo.renoux.dev`                            |
| 4050        | Vaultwarden                             | `vault.renoux.dev`                            |
| 4060        | Paperless                               | `pdf.fantom.home`                             |
| 4070        | Affine                                  | `notes.fantomitechno.dev`                     |
