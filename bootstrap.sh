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
		apt install ant build-essential clang cloud-init coreutils dbus dbus-x11 emacs figlet file findutils fortune-mod gcc geoip-database git gnupg gzip leiningen less lsb-base lsb-release lshw lsof make multiarch-support nano ncurses-base net-tools openjdk-8-jdk pngcrush python3.6 rand readline-common screen tcpdump telnet tmux toilet xauth xdelta3 xfsprogs zsh;
		os=2;
	;;
	*Microsoft)
		echo "Assuming host is WSL";
		apt install ant build-essential clang cloud-init coreutils dbus dbus-x11 emacs figlet file findutils fortune-mod gcc geoip-database git gnupg gzip leiningen less lsb-base lsb-release lshw lsof make multiarch-support nano ncurses-base net-tools openjdk-8-jdk pngcrush python3.6 rand readline-common screen tcpdump telnet tmux toilet xauth xdelta3 xfsprogs zsh;
		os=2;
	;;
	*BSD)
    echo "Assuming host is BSD";
		if [[ `groups` == *wheel* ]] || [[ `groups` == *sudo* ]]; then
			sudo pkg install git gmake gnupg zsh bash nano screen;
		fi
		os=3;
	;;
	*)
	exit 1
esac

hash -r
git clone https://github.com/zerotier/ZeroTierOne.git
cd ZeroTierOne
git checkout prod
