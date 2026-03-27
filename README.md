
![Counter-Strike](/media/banner.jpg)

# Counter-Strike 1.6 Dedicated Server as Docker Image

Probably the fastest and easiest way to set up an old-school Counter-Strike 1.6 Dedicated Server.
You don't need to know anything about Linux or HLDS to start a server. You just need Docker and this image.

## Important Caveats

- **Game Data Requirement**: This image includes the base Half-Life Dedicated Server (HLDS) with the `valve` mod for core assets (e.g., `gfx.wad`). However, Counter-Strike 1.6 mod files (`cstrike` folder) are **not included** due to licensing restrictions. You must provide your own `cstrike` folder from a legitimate Counter-Strike 1.6 client installation.
- **How to Provide CS Data**: Copy the entire `cstrike` folder from your CS 1.6 game install (typically `Steam/steamapps/common/Half-Life/cstrike`) into the `./gamedir/` directory in this project. The Docker setup will mount and sync these files into the server.
- **LAN Mode**: The server runs in LAN mode (`+sv_lan 1`) by default to avoid Steam master server dependencies. For internet play, remove `+sv_lan 1` from `docker-compose.yml` and ensure internet connectivity for Steam services.
- **Licensing**: Ensure you own Counter-Strike 1.6 on Steam. This setup uses HLDS (appid 90) with the cstrike mod.

## Quick Start

Start a new server by running:
```
docker run -it --rm -d -p27015:27015 -p27015:27015/udp memecian/cstrike
```

Change the player slot size, map or `rcon_password` by running:
```
docker run -it --rm -d --name cstrike -p27015:27015 -p27015:27015/udp memecian/cstrike +map de_dust +maxplayers 12 +rcon_password SECRET_PASSWORD
```

> **Note:** Any [server config command](http://sr-team.clan.su/K_stat/hlcommandsfull.html) can be passed by using `+`. But it has to follow after the image name `memecian/cstrike`.

The following default maps are available (after providing cstrike data):
 - cs_italy
 - de_dust
 - de_aztec
 - cs_office
 - etc. (all standard CS maps)

## Advanced

In order to use custom content like maps, server config files, or plugins, create a directory named `gamedir` and place your files there.
For an example of a custom `server.cfg` run:

```
mkdir gamedir && echo 'echo "Executing custom server.cfg"' > gamedir/server.cfg
```

Add your settings to the `server.cfg` and mount the directory as volume by running:

```
docker run -it --rm -d -p27015:27015 -p27015:27015/udp -v gamedir:/tmp/gamedir spezifanta/hldm
```

You should see `Executing custom server.cfg` in the server log when starting the server.


## About this Docker image

This image uses the latest version of [Half-Life Dedicated Server](https://developer.valvesoftware.com/wiki/HLDS) (HLDS, appid 90) with the `cstrike` mod, installed via [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD).
It includes patched versions of:

 - [Metamod v1.20](http://metamod.org/)
 - [Stripper2 v1.0.0](http://hpb-bot.bots-united.com/stripper2.html)

 Patches: https://github.com/spezifanta/metamod-p


## But why?

### Speed

Setting up a new CS 1.6 server from scratch can be tedious due to the need for base HLDS and mod files. This image streamlines the process, handling retries and configurations automatically.
It saves time on installing dependencies, configuring mods, and troubleshooting common issues.

### Sustainability

Counter-Strike 1.6 is over 20 years old. Many community resources and tutorials have gone offline. Not everyone interested in CS servers is a Linux expert.
This image ensures CS 1.6 servers remain accessible without deep technical knowledge.

I want CS 1.6 servers to live forever!

### Other reasons

- Servers often need background running tools; Docker provides a clean way to do this.
- Decoupling: Avoids installing 32-bit libs on 64-bit systems or needing admin permissions.
- Scalability and portability.


## License

MIT

## Test Server

Connect to `steamcalculator.com:27015` to give it a try.

<a href="https://www.youtube.com/watch?v=y15dfBZSx9Q" target="_blank">
<img src="/media/github-video.jpg" alt="HLDM Docker"/>
</a>
