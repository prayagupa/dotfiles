#!/bin/bash

##for 64 bit

#crate architecture
#eg. jvm_crate.sh
#    bigdata_crate.sh
#    js_crate.sh
#    util.sh
# source each crate in programmer_bootstrap.sh
#

#basePath="${PWD##*/}"
#basePath=$(dirname $0)
#basePath=$(dirname $0)
#CUR_DIR="$PWD"
#basePath="${CUR_DIR}/${0#*/}"
#basePath=$(cd $(dirname "$0"); pwd)
#app="programmer_mattress"
app="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $app/utils.sh
source $app/jvm_crate.sh
source $app/js_crate.sh
source $app/bigdata_crate.sh

echo "path => $basePath"

install32bitLibrary(){
  #echo "deb http://archive.ubuntu.com/ubuntu/ raring main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
  sudo apt-get update
  sudo apt-get install ia32-libs
}


##
installMysqlDependency(){
 sudo apt-get install libmysqlclient-dev
}


#####################################################################################
############################# golang ################################################
#####################################################################################

installGoLang(){
cat >>  ~/.bash_profile << 'EOF'
  export GOROOT=$HOME/go
  export GOOS=linux        # target operating system
  export GOARCH=amd64      # target compiling architecture
  PATH=$PATH:$GOROOT/bin 
EOF

sudo apt-get install git mercurial
wget http://go.googlecode.com/files/go1.2.1.linux-amd64.tar.gz
tar xf go1.1.1.linux-amd64.tar.gz
#rm go1.1.1.linux-amd64.tar.gz
source ~/.bash_profile

installRevel
}

installGoRevel(){
GOPATH=$HOME/gocode
mkdir $GOPATH

cat >> ~/.bash_profile << 'EOF'
 export GOPATH=$HOME/gocode
 PATH=$PATH:$GOPATH/bin 
EOF

 reloadProfileConf

 go get github.com/revel/revel
 go get github.com/revel/cmd/revel
 
 echo "######################################"
 echo "####### go revel installed. ##########"
 echo "######################################"
}


installSvn(){
	sudo apt-get install subversion
}

configureGit(){
#sudo touch /usr/local/bin/git_diff_wrapper
sudo tee -a /usr/local/bin/git_diff_wrapper  >/dev/null << 'EOF'
#!/bin/sh
vimdiff "$2" "$5"
EOF
sudo chmod 777 /usr/local/bin/git_diff_wrapper
}

installGit(){
   sudo apt-get install vim
   sudo apt-get install git

   configureGit
}

configureSSH(){
 # Testing sshd installation
 command -v which sshd >/dev/null 2>&1
 INSTALLED=$?
 echo ""

 # Checking sshd if installed
 if [ -n "$INSTALLED" ] ; then
	 echo "[INFO] : installing ssh"
   sudo apt-get install ssh
 fi
}



installMysql(){
				sudo apt-get install mysql-server
}


installHipchat(){
sudo su
echo "deb http://downloads.hipchat.com/linux/apt stable main" > \
				  /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
apt-get update
apt-get install hipchat
}

installAdobeAir(){
				#wget http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRInstaller.bin
				sudo chmod a+x /packup/repo.softwares/linux/adobeair2.6/AdobeAIRInstaller.bin && sudo /packup/repo.softwares/linux/adobeair2.6/AdobeAIRInstaller.bin
}

installAdobeAir26(){
				sudo apt-get install libxt6:i386 libnspr4-0d:i386 libgtk2.0-0:i386 libstdc++6:i386 libnss3-1d:i386 lib32nss-mdns libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386
				sudo apt-get install libgnome-keyring0:i386
				cd /tmp
				sudo apt-get download libgnome-keyring0:i386
				sudo dpkg-deb -R libgnome-keyring0_3.6.0-1_i386.deb gnome-keyring ##verify version
				sudo cp gnome-keyring/usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/i386-linux-gnu/
				sudo ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/i386-linux-gnu/libgnome-keyring.so.0
				sudo ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0
				sudo ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

				installAdobeAir

				sudo rm /usr/lib/libgnome-keyring.so.0
				sudo rm /usr/lib/libgnome-keyring.so.0.2.0
}

##
## @see : http://www.tkalin.com/blog_posts/installing-adobe-air-and-elance-tracker-on-ubuntu-13-10-saucy-salamander-64-bit
##
installElanceTracker(){
				installAdobeAir26
				sudo dpkg -i /packup/repo.softwares/linux/TrackerSetup.deb
}



installErlang(){
    sudo apt-get update && sudo apt-get install erlang 
}



##https://www.virtualbox.org/wiki/Linux_Downloads
installVBox(){
	VBox_MAJ_VERSION="4.2"    #"4.3"
	VBox_MIN_VERSION="4.2.24" #"4.3.12"
        VBox_TOOL="virtualbox-$VBox_MAJOR_VERSION_$VBox_MIN_VERSION"
	#VBox_TOOL_DEB="virtualbox-4.3_4.3.12-93733~Ubuntu~raring_amd64.deb"
	VBox_TOOL_DEB="virtualbox-4.2_4.2.24-92790~Ubuntu~raring_amd64.deb"
	VBox_URL="http://download.virtualbox.org/virtualbox/$VBox_MIN_VERSION/$VBox_TOOL_DEB"
	if [ ! -e $VBox_TOOL_DEB ]; then
	   wgetIt $VBox_URL
        else
           echo "[info] : $DEFAULT_SOURCE_ROOT/$VBox_TOOL_DEB exists"
        fi
        dpkgInstall "$DEFAULT_SOURCE_ROOT/$VBox_TOOL_DEB"
}

installUnetBootIn(){
	sudo apt-get install p7zip
	sudo apt-get install p7zip-full
	UNET_DOWNLOAD_URL="http://unetbootin.sourceforge.net/unetbootin-linux-latest"
	wgetIt $UNET_DOWNLOAD_URL 
        sudo $DEFAULT_SOURCE_ROOT/unetbootin-linux-603
}

programmer_setup_init(){
    installGit
    installClj
    installJdk
    installGrails
    installElasticsearch
    installMysql
}

#programmer_setup_init

#programmerSetup(){
    #show options to install tools
    #ask to enter a command
#}
