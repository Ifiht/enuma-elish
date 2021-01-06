#!/bin/sh
set -u

os=`uname`;
# First check what OS we're on:
case "$os" in
	macos)
		echo "Assuming host is OS X";
		os=1;
	;;
	linux)
		echo "Assuming host is Linux";
		sudo apt update && sudo apt upgrade -y;
		sudo apt install ant build-essential clang cloud-init coreutils dbus dbus-x11 emacs figlet file findutils fortune-mod gcc geoip-database git gnupg gzip leiningen less lsb-base lsb-release lshw lsof make multiarch-support nano ncurses-base net-tools openjdk-8-jdk pngcrush python3.6 rand readline-common screen tcpdump telnet tmux toilet xauth xdelta3 xfsprogs zsh;
		os=2;
	;;
	*Microsoft)
		echo "Assuming host is WSL";
		sudo apt update && sudo apt upgrade -y;
		sudo apt install ant build-essential clang cloud-init coreutils dbus dbus-x11 emacs figlet file findutils fortune-mod gcc geoip-database git gnupg gzip leiningen less lsb-base lsb-release lshw lsof make multiarch-support nano ncurses-base net-tools openjdk-8-jdk pngcrush python3.6 rand readline-common screen tcpdump telnet tmux toilet xauth xdelta3 xfsprogs zsh;
		os=2;
	;;
	*BSD)
		echo "Assuming host is BSD";
		sudo freebsd-update fetch && sudo freebsd-update install;
		sudo pkg upgrade;
		sudo portsnap auto;
		sudo pkg install git gmake gnupg zsh bash nano ruby screen;
		os=3;
	;;
	*)
	exit 1
esac

hash -r
git clone https://github.com/Ifiht/ZeroTierOne.git
cd ZeroTierOne
git checkout prod
