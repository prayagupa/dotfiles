minimalUbuntu(){
  sudo apt-get purge thunderbird* #51.4 mb
	sudo apt-get purge empathy
	sudo apt-get purge ubuntuone-client python-ubuntuone-storage*
  sudo apt-get remove gnome-contacts
}

setupUbuntuForProgramming(){
#chrome install
sudo apt-get install libxss1 && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i google-chrome*.deb

sudo apt-get install vim
sudo apt-get install git

## power-mgmt
## https://help.ubuntu.com/community/PowerManagement/ReducedPower
sudo apt-get update
sudo apt-get install -y powertop
sudo apt-get install -y pm-utils
sudo pm-powersave true

# http://www.webupd8.org/2012/07/monitor-hardware-temperature-in-ubuntu.html
sudo apt-get install lm-sensors hddtemp
sudo apt-get install psensor


##sensors
#sudo apt-get install acpi
#sudo apt-get install -y lm-sensors sensors-applet


##Two-finger scrolling
##http://askubuntu.com/a/373053/37643
##http://askubuntu.com/a/373134/37643
echo synclient VertEdgeScroll=1      >> ~/.conf/scroll-touchpad
echo synclient VertTwoFingerScroll=1 >> ~/.conf/scroll-touchpad
chmod +x ~/.conf/scroll-touchpad
chmod -w ~/.conf/scroll-touchpad

gsettings set org.gnome.settings-daemon.peripherals.input-devices hotplug-command '"'$HOME'/.conf/scroll-touchpad"'

##Sensors Indicator
##http://www.noobslab.com/2013/04/panel-indicators-collection-for-ubuntu.html
sudo add-apt-repository ppa:noobslab/indicators
sudo apt-get update
sudo apt-get install -y indicator-sensors lm-sensors
}


setupNonProgramming(){
##music player
##http://www.noobslab.com/2013/10/clementine-player-12-version-released.html
sudo add-apt-repository ppa:me-davidsansome/clementine
sudo apt-get update
sudo apt-get install -y clementine
}
