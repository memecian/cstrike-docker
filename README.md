
![Half-Life](/media/banner.jpg)

# Counter-Strike 1.6 Server as Docker image

An easy way to set up a Counter-Strike 1.6 Dedicated Server (CSDS) using Docker.
Based on ["Probably the fastest and easiest way to set up an old-school Half-Life Deathmatch Dedicated Server"](https://github.com/spezifanta/hldm-docker) by spezifanta.
You don't need to know anything about Linux or HLDS to start a server. You just need Docker and this image.

## Important Caveats

- **Game Data Requirement**: This image includes the base Half-Life Dedicated Server (HLDS) with the `valve` mod for core assets. However, Counter-Strike 1.6 mod files (`cstrike` folder) are **not included** due to licensing. You must provide your own `cstrike` folder from a legitimate CS 1.6 client installation.
- **How to Provide CS Data**: Copy the entire `cstrike` folder from your CS 1.6 game install into the `./gamedir/` directory. The Docker setup will mount and sync these files.
- **LAN Mode**: Runs in LAN mode by default. For internet play, modify `docker-compose.yml`.
- **Licensing**: Ensure you own Counter-Strike 1.6 on Steam.

## Quick Start

Start a new server by running:
```
docker run -it --rm -d -p27015:27015 -p27015:27015/udp memecian/cstrike
```

Change the player slot size, map or `rcon_password` by running:
```
docker run -it --rm -d --name cstrike -p27015:27015 -p27015:27015/udp memecian/cstrike +map de_dust +maxplayers 12 +rcon_password SECRET_PASSWORD
```

> **Note:** Any [server config command](http://sr-team.clan.su/K_stat/hlcommandsfull.html) can be passed using `+`.

The following default maps are available (after providing cstrike data):
 - de_dust
 - cs_italy
 - de_aztec
 - cs_office
 - etc. (standard CS maps)


## Advanced

In order to use a custom content like maps or server config file, create a directory named `gamedir` and place your files there.
For an example of a custom `server.cfg` run:

```
mkdir gamedir && echo 'echo "Executing custom server.cfg"' > gamedir/server.cfg
```

Add your settings to the `server.cfg` and mount the directory as volume by running:

```
docker run -it --rm -d -p27015:27015 -p27015:27015/udp -v gamedir:/tmp/gamedir memecian/cstrike
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

Setting up a CS 1.6 server from scratch requires HLDS and mod files. This image handles the installation and configuration automatically, saving time on retries and setups.

### Other reasons

- Servers need background management; Docker simplifies this.
- Decoupling: Avoids 32-bit lib installs on 64-bit systems.
- Scalability and portability.


## License

MIT

## Test Server

Connect to `redspecced.me:27016` to give it a try.
