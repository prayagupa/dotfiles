
minimalUbuntu(){
  sudo apt-get purge thunderbird* #51.4 mb
  sudo apt-get purge empathy
  sudo apt-get purge ubuntuone-client python-ubuntuone-storage*
  sudo apt-get remove gnome-contacts
}


setupUbuntuForProgramming(){
  #chrome install
  sudo apt-get install libxss1 && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i google-chrome*.deb

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

alsaReload(){
   sudo apt-get remove --purge alsa-base pulseaudio
   sudo apt-get install alsa-base pulseaudio
   sudo alsa force-reload
}

installSkype(){
				sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
				sudo apt-get update 
				sudo apt-get install skype
}

##http://askubuntu.com/a/224800/37643
##Rhythmbox requires to install plugins to play media files of the following type: text/html decoder
##
installMediaLibs(){
	sudo apt-get install libcdaudio1 libflite1 libgme0 libgstreamer-plugins-bad0.10-0 libmimic0 libofa0 libslv2-9 libspandsp2 libvo-aacenc0 libvo-amrwbenc0 libwildmidi-config libwildmidi1 libzbar0 gstreamer0.10-plugins-bad 
}

#didnt work for rhythmbox 2.8
installRhythmboxPlugins(){
	rm -rf ~/.local/share/rhythmbox/plugins/coverart_browser
	git clone https://github.com/fossfreedom/coverart-browser.git
	cd coverart-browser
	./install.sh
}

installRhythmbox3(){
	sudo add-apt-repository ppa:jacob/media
	sudo apt-get update
	sudo apt-get install rhythmbox
}

#http://code.google.com/p/tab-rhythmbox-plugin/wiki/Installation
installRhythmboxGuitarPlugin(){
	wget http://tab-rhythmbox-plugin.googlecode.com/svn/trunk/svn_install.sh
	sudo chmod +x svn_install.sh
	sudo ./svn_install.sh
}

powerConf(){
	sudo apt-get install indicator-cpufreq
}

installNumix(){
	sudo apt-get install gnome-tweak-tool

	sudo add-apt-repository ppa:numix/ppa
	echo ""
	echo "##### added ppa:mumix ###########3"
	echo ""

        sudo apt-get update
	sudo apt-get install numix-icon-theme-circle
	#change icon theme
	#http://itsfoss.com/how-to-install-themes-in-ubuntu-13-10/
	#http://www.noobslab.com/2011/10/install-gnome-tweak-tool-in-ubuntu-1110.html

	echo "starting gnome-tweak-too"
	gnome-tweak-tool
}
