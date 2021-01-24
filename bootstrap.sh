#!/bin/sh
set -u

wget https://github.com/zerotier/ZeroTierOne/archive/1.6.2.tar.gz
tar -xzf 1.6.2.tar.gz
cd ZeroTierOne-1.6.2

os=`uname`;
# First check what OS we're on:
case "$os" in
	macos)
		echo "Assuming host is OS X";
		gmake; # compiles zerotier-one
		os=1;
	;;
	linux)
		echo "Assuming host is Linux";
		sudo apt update && sudo apt upgrade -y;
		sudo apt install clang coreutils file findutils fortune-mod gcc geoip-database git gnupg gzip less lsb-base lsb-release lshw lsof make multiarch-support nano ncurses-base net-tools openjdk-8-jdk pngcrush python3.6 rand readline-common screen tcpdump telnet xfsprogs zsh;
		make; # compiles zerotier-one
		os=2;
	;;
	*Microsoft)
		echo "Assuming host is WSL";
		sudo apt update && sudo apt upgrade -y;
		sudo apt install clang coreutils file findutils fortune-mod gcc geoip-database git gnupg gzip less lsb-base lsb-release lshw lsof make multiarch-support nano ncurses-base net-tools openjdk-8-jdk pngcrush python3.6 rand readline-common screen tcpdump telnet xfsprogs zsh;
		make; # compiles zerotier-one
		os=2;
	;;
	*BSD)
		echo "Assuming host is BSD";
		sudo freebsd-update fetch && sudo freebsd-update install;
		sudo pkg upgrade;
		sudo portsnap auto;
		sudo pkg install git gmake gnupg zsh bash nano ruby screen;
		gmake; # compiles zerotier-one
		os=3;
	;;
	*)
	exit 1
esac

sudo zerotier-one -d
sudo zerotier-cli join 12ac4a1e7110d239
hash -r
