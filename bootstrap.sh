#!/bin/sh
set -u

inst_z=0;

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
		sudo apt install clang coreutils file findutils fortune-mod gcc geoip-database git gnupg gzip less lsb-base lsb-release lshw lsof make multiarch-support nano ncurses-base net-tools openjdk-8-jdk pngcrush python3.6 rand readline-common screen tcpdump telnet xfsprogs zsh;
		os=2;
	;;
	*Microsoft)
		echo "Assuming host is WSL";
		sudo apt update && sudo apt upgrade -y;
		sudo apt install clang coreutils file findutils fortune-mod gcc geoip-database git gnupg gzip less lsb-base lsb-release lshw lsof make multiarch-support nano ncurses-base net-tools openjdk-8-jdk pngcrush python3.6 rand readline-common screen tcpdump telnet xfsprogs zsh;
		make; # compiles zerotier-one
		os=3;
	;;
	*BSD)
		echo "Assuming host is BSD";
		sudo freebsd-update fetch && sudo freebsd-update install;
		sudo pkg upgrade;
		sudo portsnap auto;
		sudo pkg install git gmake gnupg zsh bash nano ruby screen;
		os=4;
	;;
	*)
	exit 1
esac

if [ os -eq 3 ]
	echo "Please install zerotier manually to continue..."
else
	wget https://github.com/zerotier/ZeroTierOne/archive/1.6.4.tar.gz
	tar -xzf 1.6.4.tar.gz
	cd ZeroTierOne-1.6.4
	inst_z=1;
fi

if [ os -eq 1 ] 
	gmake; # compiles zerotier-one
elif [ os -eq 2 ]
	make; # compiles zerotier-one
elif [ os -eq 4 ]
	gmake; # compiles zerotier-one
fi

if [ inst_z -eq 1 ]
	sudo zerotier-one -d
	sudo zerotier-cli join 12ac4a1e7110d239
fi	
hash -r
