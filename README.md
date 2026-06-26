# fantom's Dotfiles

At first inspired by [JotaFab/s13los](https://github.com/JotaFab/s13los)

Desktop Environement is built with Waybar and Niri but can also be KDE as a backup

These dotfiles are used for

- my laptop (fantomitechno-laptop)
- my desked laptop (fantomitechno-msi)
- my desktop (fantomitechno-desktop)
- my homelab servers (conseil and fant0mib0t)

# How to use

## Create an iso installer

```sh
nix build --no-link --print-out-paths ".#installer"
```

## Rebuild and switch on an existing configuration

```sh
rebuild
# or
cd /home/fantomitechno/dotfiles && sudo nixos-rebuild switch --flake
```

For this you'll need the hostname to be set to an already existing configuration

# Wallpaper Credits

- `09_Troposphere.jpg`, `12_paint.jpg`, `18_AGiftFromtheStars.jpg`, `L01_Oceanfront.jpg` and `L03_PinwheelBay.jpg`: Fuwamo ([twtr](https://x.com/iloli_i8g) [bsky](https://bsky.app/profile/fuwamo-8g.bsky.social))
- `event_act1_1intro3.png`, `event_act5_falling_reso_5.png`, `falling_1920x1080.png`, `resolution_1920x1080.png`, `sifintro_1_1920x1080.png`, `sifintro_2_1920x1080.png` and `sifintro_3_1920x1080.png`: In Stars And Time by insertdisc5 ([itch](https://armor-games-studios.itch.io/in-stars-and-time) [stm](https://store.steampowered.com/app/1677310/In_Stars_And_Time/))
- `madeline_bed.png`: Celeste by Extremly OK Games ([stm](https://store.steampowered.com/app/504230/Celeste/))
- `lux_wallpapere_v1.png`, `lux_wallpapere_v2.png` and `folly_wlalaper.png`: AlexxWinters\_ ([crd.co](https://alexxswinters.carrd.co/))
- `red_and_yellow.jpg`: Undertale: Red And Yellow by Sinix and more ([gmjlt](https://gamejolt.com/games/undertale-red-yellow/877387))
- `sol_rue.jpg`: (Extended Version of) OneShot by Future Cat Games ([stm](https://store.steampowered.com/app/420530/OneShot/))
- `undertale_yellow.png`: Undertale Yellow by Team Undertale Yellow ([gmjlt](https://gamejolt.com/games/UndertaleYellow/136925))
- `banned_and_forgotten.png`: Commission by Sayo ([crd.co](https://faudarzdsayo.carrd.co/))
- `fantom_deloreane.gif`: Commission by cocoNOTshell (they deleted all socials :c)
- `deltarune_chapter_5_teaser.png` by Temmie Chang ([site](https://temstuff.neocities.org/)) for Deltarune Chapter 5 reveal trailer ([stm](https://store.steampowered.com/app/1671210/DELTARUNE/) [site](https://deltarune.com/))

# Fastfetch prompt Credits

Picrew, a lot of them, all of them really