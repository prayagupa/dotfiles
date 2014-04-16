
DEFAULT_SOURCE_ROOT="/packup/repo.softwares"
DEFAULT_INSTALLATION_DEST="/usr/local/"

32bitLibrary(){
  #echo "deb http://archive.ubuntu.com/ubuntu/ raring main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
  sudo apt-get update
  sudo apt-get install ia32-libs
}


installJdk(){
 ####################################################################
 ################JDK#################################################
 ####################################################################
 JDK_VERSION="1.7.0"

 # Testing java installation
 command -v java -version >/dev/null 2>&1
 INSTALLED=$?
 echo ""

 # Checking java if installed
 if [ -n "$INSTALLED" ] ; then
    JDK_DOWNLOAD_URL="http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz"
    JDK_LOCATION_SOURCE="/packup/repo.softwares/JVM/JDK/JDK1.7.0/jdk$JDK_VERSION"

    JDK_LOCATION_DESTINATION="/usr/local/"

    sudo mv $JDK_LOCATION_SOURCE  $JDK_LOCATION_DESTINATION

    ls -l $JDK_LOCATION_DESTINATION

    sudo chmod 777 -R /usr/local/jdk1.7.0/

    #echo "JAVA_HOME=$JDK_LOCATION_DESTINATION/jdk$JDK_VERSION; export JAVA_HOME" >> ~/.bash_profile
    #echo "PATH=$JAVA_HOME/bin:$PATH; export PATH"                                >> ~/.bash_profile

 cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### JDK ###############
  ###############################
  JAVA_HOME=/usr/local/jdk1.7.0
  export JAVA_HOME
  export PATH=$PATH:$JAVA_HOME/bin
EOF

   source ~/.bash_profile

   echo "####################################################"
   echo "[info] : jdk $JDK_VERSION is installed successfully."
   echo "####################################################"

   #java -version
 fi
}

installClj(){
      curl https://raw.github.com/technomancy/leiningen/stable/bin/lein > lein
      sudo mv lein /usr/bin/
      sudo chmod +x /usr/bin/lein 
      #lein repl
}

scalaInstall(){
 SCALA_VERSION="2.10.3"
 SCALA_LOCATION_SOURCE="/packup/repo.softwares/JVM/scala/scala$SCALA_VERSION.tgz"
 
 SCALA_LOCATION_DESTINATION="/usr/local/"
 
 sudo tar -zxvf $SCALA_LOCATION_SOURCE -C $SCALA_LOCATION_DESTINATION
 #sudo mv $SCALA_LOCATION_SOURCE  $SCALA_LOCATION_DESTINATION

 ls -l $SCALA_LOCATION_DESTINATION

 sudo chmod 777 -R /usr/local/scala-$SCALA_VERSION

 cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### SCALA #############
  ###############################
  SCALA_HOME=/usr/local/scala-2.10.3
  export SCALA_HOME
  export PATH=$PATH:$SCALA_HOME/bin
EOF

 source ~/.bash_profile

 echo "##################################################"
 echo "[info] : $SCALA_VERSION is installed successfully."
 echo "##################################################"

}


installGrails(){
 GRAILS_VERSION="2.2.3"
 GRAILS_LOCATION_SOURCE="$DEFAULT_SOURCE_ROOT/JVM/GroovyOnGrails/grails-$GRAILS_VERSION.zip"
 
 sudo unzip $GRAILS_LOCATION_SOURCE -d $DEFAULT_INSTALLATION_DEST
 sudo chmod 777 -R /usr/local/grails-$GRAILS_VERSION

# cat >> ~/.bash_profile <<'EOF'
#  ###############################
#  ########### grails #############
#  ###############################
#  JAVA_HOME=/usr/local/grails-2.2.3
#  export GRAILS_HOME
#  export PATH=$PATH:$GRAILS_HOME/bin
#EOF

 reloadProfileConf

 echo "####################################################"
 echo "[info] : $GRAILS_VERSION is installed successfully."
 echo "####################################################"

}

installIntelliJ(){
  SOURCE_LOCATION="/packup/repo.softwares/JVM/IDEs/idea/ideaIU-13.tar.gz"
	DEST_LOCATION="/usr/local"
	DEST_FOLDER="idea-IU-133.193"
  sudo tar -zxvf $SOURCE_LOCATION -C $DEST_LOCATION/
  sudo chmod 777 -R $DEST_LOCATION/$DEST_FOLDER
  
	echo " ####################################################################"
  echo " [info] : Intellij is installed to /usr/local."
	echo " ####################################################################"

sudo tee -a $DEST_LOCATION/$DEST_FOLDER/bin/studio64.vmoptions >/dev/null << 'EOF'
	cat >> << 'EOF'
	-Xms1024m
	-Xmx1024m
	-XX:MaxPermSize=1024m
	-XX:ReservedCodeCacheSize=96m
	-ea
	-Dsun.io.useCanonCaches=false
	-Djava.net.preferIPv4Stack=true
	-XX:+UseCodeCacheFlushing
	-XX:+UseConcMarkSweepGC
	-XX:SoftRefLRUPolicyMSPerMB=50
	-XX:+HeapDumpOnOutOfMemoryError
	-Dawt.useSystemAAFontSettings=lcd
EOF
}

#################################################################################################
########################## ANDROID ##############################################################
#################################################################################################
androidInstall(){
  ANDROID_STUDIO_LOCATION="/media/prayagupd/Elements/_backup/backup/android-studio-prayag.zip"
  sudo unzip $ANDROID_STUDIO_LOCATION -d /usr/local/
  sudo chmod 777 -R /usr/local/android-studio
  echo "Android studio installed to /usr/local."
cat >> /usr/local/android-studio/bin/studio64.vmoptions << 'EOF'
	-Xms1024m
	-Xmx1024m
	-XX:MaxPermSize=1024m
	-XX:ReservedCodeCacheSize=96m
	-ea
	-Dsun.io.useCanonCaches=false
	-Djava.net.preferIPv4Stack=true
	-XX:+UseCodeCacheFlushing
	-XX:+UseConcMarkSweepGC
	-XX:SoftRefLRUPolicyMSPerMB=50
	-XX:+HeapDumpOnOutOfMemoryError
	-Dawt.useSystemAAFontSettings=lcd
EOF
  #/usr/local/android-studio/bin/studio.sh > /usr/local/android-studio/studio.log &
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

reloadProfileConf(){
 source ~/.bash_profile
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


installElasticsearch(){
				sudo tar -zxvf /packup/repo.softwares/JVM/Solr-Lucene-ES\(Big\ Data\)/elasticsearch-1.0.0.tar.gz -C /usr/local/
				sudo chmod -R ugo+rw /usr/local/elasticsearch-1.0.0/
}

installMysql(){
				sudo apt-get install mysql-server
}


# https://github.com/nathanmarz/storm/wiki/Setting-up-development-environment

installStorm(){
	STORM_VERSION=0.8.2
	SOURCE="storm-$STORM_VERSION"
	DESTINATION="/usr/local"
	#wget https://dl.dropboxusercontent.com/s/fl4kr7w0oc8ihdw/storm-0.8.2.zip?dl=1&token_hash=AAEAQiAKkgRc2Y2YI7zmIBOWe06neX5APneao4hUzO2bEQ
	
	sudo unzip $SOURCE.zip -d $DESTINATION
	sudo chmod 777 -R $DESTINATION/$SOURCE
cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### STORM ###############
  ###############################
  STORM_HOME=/usr/local/storm-0.8.2
  export STORM_HOME
  export PATH=$PATH:$STORM_HOME/bin
EOF

   reloadProfileConf

   echo "####################################################"
   echo "[info] : $STORM_VERSION is installed successfully."
   echo "####################################################"
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


## http://www.mongodb.org/downloads

##TODO
installMongodb(){
   wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.6.0.tgz
}

init(){
    installGit
    installClj
    installJdk
		installGrails
    installElasticsearch
    installMysql
}

#init
