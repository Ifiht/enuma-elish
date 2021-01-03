# enuma-elish
In the beginning...

```/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Ifiht/enuma-elish/main/bootstrap.sh)"```

Steps used to create stand-alone planets file (ripped from [Gotz](https://gotz.co/2019/02/17/mpls-over-zerotier-pt-1/)):
1. Go into the world folder inside the attic `cd ZeroTierOne/attic/world`
2. Edit the mkworld.cpp file. Remove the IP addresses of the ZeroTier Controllers and add your own. ZeroTier has 2 controllers, but more can be added.
3. Build the file `source ./build.sh`
4. Run the mkworld file: `./mkworld` A new world.bin file should be created. This will be the file that all of your nodes need.
5. Copy the world.bin file to your ZeroTier-One folder `cp world.bin /var/lib/zerotier-one/planet`(Linux) `cp world.bin /var/db/zerotier-one/planet`(BSD)
6. Restart ZeroTier `sudo systemctl restart zerotier-one.service`
7. Copy the world.bin file and repeat Steps 7 and 8 to each node you want to use.
