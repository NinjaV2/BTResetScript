#!/bin/sh
# Check if shell is bash or ZSH
if [ -n "$BASH_VERSION" ]; then
	# bash commands
	echo "Disabling Bluetooth drivers..."
	if lsmod | grep -q "^rfcomm "; then	
		echo "rfcomm found"
		echo "first wave ~~ btusb, btrtl, btintel, rfcomm and btbcm"
		sudo rmmod btusb btrtl btintel rfcomm btbcm
		echo "stopping bluetooth.service"
		sudo systemctl stop bluetooth.service
		echo "second wave ~~ bnep and bluetooth"
		sudo rmmod bnep bluetooth
	else
		echo "rfcomm not found"
		echo "first wave ~~ btusb, btrtl, btintel and btbcm"
		sudo rmmod btusb btrtl btintel btbcm
		echo "stopping bluetooth.service"
		sudo systemctl stop bluetooth.service
		echo "second wave ~~ bnep and bluetooth"
		sudo rmmod bnep bluetooth
	fi
	
	sleep 5
	echo "Enabling Bluetooth drivers..."
	echo "rfcomm not found, going to work..."
	echo "enabling first wave ~~ btusb, bnep, bt ~~"
	sudo modprobe btusb bnep bluetooth
	echo "enabling second wave ~~ btrtl, btintel, rfcomm, btbcm"
	sudo modprobe btrtl btintel rfcomm btbcm
	echo "starting bluetooth service"
	sudo systemctl start bluetooth.service
else
	echo "Unsupported shell, something with execution got fucked."
	echo "Try running with "bash -x name.sh""
	exit 1
	# sudo rmmod btusb bnep bluetooth btrtl btintel btbcm
	# correct way to disable things goes as follows:
	# rmmod btusb -> btrtl -> btintel -> rfcomm (if in use) -> btbcm
	# sudo systemctl stop bluetooth -> rmmod bnep -> bluetooth
fi
