##for 64 bit

DEFAULT_SOURCE_ROOT="/packup/repo.softwares"
DEFAULT_SOURCE_ROOT_JVM="/packup/repo.softwares/JVM"
DEFAULT_INSTALLATION_DEST="/usr/local/"

#########################################################################
##global functions
#########################################################################

reloadProfileConf(){
 source ~/.bash_profile
}

unzipIt(){
	sudo unzip $1 -d $DEFAULT_INSTALLATION_DEST
}

setPermissionRWE(){
				sudo chmod -R 777 $1

}

setPermission(){
				sudo chmod -R ugo+rw $1
}

wgetIt(){
   wget $1 -P $DEFAULT_SOURCE_ROOT
}

showMessage(){
 echo "##################################################"
 echo "[info] : $1 $2 is installed successfully."
 echo "##################################################"
}
#########################################################################

install32bitLibrary(){
  #echo "deb http://archive.ubuntu.com/ubuntu/ raring main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
  sudo apt-get update
  sudo apt-get install ia32-libs
}

####################################################################
################JDK#################################################
####################################################################
installJdk(){
 JDK_VERSION="1.7.0"

 # Testing java installation
 command -v java -version >/dev/null 2>&1
 INSTALLED=$?
 echo ""

 # Checking java if installed
 if [ -n "$INSTALLED" ] ; then
    JDK_DOWNLOAD_URL="http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz"
    JDK_LOCATION_SOURCE="$DEFAULT_SOURCE_ROOT/JVM/JDK/JDK1.7.0/jdk$JDK_VERSION"

    sudo mv $JDK_LOCATION_SOURCE  $DEFAULT_INSTALLATION_DEST
    sudo chmod 777 -R $DEFAULT_INSTALLATION_DEST/jdk1.7.0/

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
 fi
}

installClj(){
      curl https://raw.github.com/technomancy/leiningen/stable/bin/lein > lein
      sudo mv lein /usr/bin/
      sudo chmod +x /usr/bin/lein 
      #lein repl
}

installScala(){
 SCALA_VERSION="2.10.3"
 SCALA_LOCATION_SOURCE="$DEFAULT_SOURCE_ROOT/JVM/scala/scala$SCALA_VERSION.tgz"
 
 sudo tar -zxvf $SCALA_LOCATION_SOURCE -C $DEFAULT_INSTALLATION_DEST
 sudo chmod 777 -R $DEFAULT_INSTALLATION_DEST/scala-$SCALA_VERSION

 cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### SCALA #############
  ###############################
  SCALA_HOME=/usr/local/scala-2.10.3
  export SCALA_HOME
  export PATH=$PATH:$SCALA_HOME/bin
EOF

 reloadProfileConf

 echo "##################################################"
 echo "[info] : $SCALA_VERSION is installed successfully."
 echo "##################################################"

}


installPlayFramework(){
				PLAY_VERSION="2.2.2"
				PLAY_URL="http://downloads.typesafe.com/play/$PLAY_VERSION/play-$PLAY_VERSION.zip"
				wget $PLAY_URL  -P $DEFAULT_SOURCE_ROOT_JVM/scala/
				sudo unzip  $DEFAULT_SOURCE_ROOT_JVM/scala/play-$PLAY_VERSION -d $DEFAULT_INSTALLATION_DEST
        setPermissionRWE $DEFAULT_INSTALLATION_DEST/play-$PLAY_VERSION
 cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### play #############
  ###############################
  PLAY_HOME=/usr/local/play-2.2.2
  export PLAY_HOME
  export PATH=$PATH:$PLAY_HOME/
EOF

 reloadProfileConf
 showMessage "play" $PLAY_VERSION
}

installGrails(){
 GRAILS_TOOL="grails"
 GRAILS_VERSION="2.3.3"
 GRAILS_LOCATION_SOURCE="$DEFAULT_SOURCE_ROOT_JVM/GroovyOnGrails/$GRAILS_TOOL-$GRAILS_VERSION.zip"
 unzipIt $GRAILS_LOCATION_SOURCE
 setPermissionRWE $DEFAULT_INSTALLATION_DEST/$GRAILS_TOOL-$GRAILS_VERSION

# cat >> ~/.bash_profile <<'EOF'
#  ###############################
#  ########### grails #############
#  ###############################
#  JAVA_HOME=/usr/local/grails-2.2.3
#  export GRAILS_HOME
#  export PATH=$PATH:$GRAILS_HOME/bin
#EOF

 reloadProfileConf
 showMessage $TOOL $GRAILS_VERSION
}

installIntelliJ(){

  SOURCE_LOCATION="$DEFAULT_SOURCE_ROOT/JVM/IDEs/idea/ideaIU-13.tar.gz"
  DEST_FOLDER="idea-IU-133.193"

  sudo tar -zxvf $SOURCE_LOCATION -C $DEFAULT_INSTALLATION_DEST
  sudo chmod 777 -R $DEFAULT_INSTALLATION_DEST/$DEST_FOLDER
  
  echo " ####################################################################"
  echo " [info] : Intellij is installed to $DEFAULT_INSTALLATION_DEST."
  echo " ####################################################################"

sudo tee -a $DEFAULT_INSTALLATION_DEST/$DEST_FOLDER/bin/studio64.vmoptions >/dev/null << 'EOF'
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
  ANDROID_STUDIO_LOCATION="$DEFAULT_SOURCE_ROOT/android-studio-prayag.zip"
  sudo unzip $ANDROID_STUDIO_LOCATION -d $DEFAULT_INSTALLATION_DEST
  sudo chmod 777 -R $DEFAULT_INSTALLATION_DEST/android-studio
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


installElasticsearch(){
				VERSION_ES="1.1.0"
				ES_HOME=$DEFAULT_INSTLLATION_DEST/elasticsearch-$ES_VERSION
				sudo tar -zxvf $DEFAULT_SOURCE_ROOT_JVM/SolrLuceneES-BigData/elasticsearch-$VERSION_ES.tar.gz -C $DEFAULT_INSTALLATION_DEST
				sudo chmod -R ugo+rw $ES_HOME
          	                $ES_HOME/bin/plugin -i elasticsearch/marvel/latest
}

installMysql(){
				sudo apt-get install mysql-server
}


# https://github.com/nathanmarz/storm/wiki/Setting-up-development-environment

installStorm(){
	STORM_VERSION=0.8.2
	SOURCE="storm-$STORM_VERSION"
	#wget https://dl.dropboxusercontent.com/s/fl4kr7w0oc8ihdw/storm-0.8.2.zip?dl=1&token_hash=AAEAQiAKkgRc2Y2YI7zmIBOWe06neX5APneao4hUzO2bEQ
	
	sudo unzip $SOURCE.zip -d $DEFAULT_INSTALLATION_DEST
	sudo chmod 777 -R $DEFAULT_INSTALLATION_DEST/$SOURCE
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
   echo "[info] : storm $STORM_VERSION is installed successfully."
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


tarIt(){
   sudo tar -zxvf $1  -C $DEFAULT_INSTALLATION_DEST
}

## http://www.mongodb.org/downloads
## http://prayag-waves.blogspot.com/2012/11/hacking-on-grails-and-mongodb.html
## http://docs.mongodb.org/manual/tutorial/install-mongodb-on-linux/

installMongodb(){
   MONGO_VERSION="2.6.0"
   MONGO_FILE="mongodb-linux-x86_64-$MONGO_VERSION.tgz"
   #wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.6.0.tgz
   tarIt $DEFAULT_SOURCE_ROOT/$MONGO_FILE
cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### MONGO #############
  ###############################
  MONGODB_HOME=/usr/local/mongodb-linux-x86_64-2.6.0
  export MONGODB_HOME
  export PATH=$PATH:$MONGODB_HOME/bin
EOF

DB_PATH="/data/db"
sudo mkdir -p $DB_PATH
setPermission $DB_PATH

   #sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
   #echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
   #sudo apt-get update
   #sudo apt-get install mongodb-org
   #sudo apt-get install mongodb-org=2.6.1 mongodb-org-server=2.6.1 mongodb-org-shell=2.6.1 mongodb-org-mongos=2.6.1 mongodb-org-tools=2.6.1
}

installDatomic(){
	DATOMIC_VERSION="0.9.4724"
	DATOMIC_FILE="datomic-free-$DATOMIC_VERSION"
	DOWNLOAD_URL="https://my.datomic.com/downloads/free/$DATOMIC_VERSION"
	#wget doesn't work
	#wget $DOWNLOAD_URL -P $DEFAULT_SOURCE_ROOT
	unzipIt $DEFAULT_SOURCE_ROOT/$DATOMIC_FILE.zip
	setPermission $DEFAULT_INSTALLATION_DEST/$DATOMIC_FILE
cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### DATOMIC ###########
  ###############################
  DATOMIC_HOME=/usr/local/datomic-free-0.9.4724
  export DATOMIC_HOME
  export PATH=$PATH:$DATOMIC_HOME/bin
EOF
 reloadProfileConf
}

installErlang(){
    sudo apt-get update && sudo apt-get install erlang 
}

installNeo4j(){
	NEO4J_VERSION="1.9.7"
	NEO4J_FILE="neo4j-community-$NEO4J_VERSION"
	NEO4J_FILE_TAR="$NEO4J_FILE-unix.tar.gz"
	NEO4J_DOWNLOAD_URL_="http://dist.neo4j.org/neo4j-community-1.9.7-unix.tar.gz"
	#wget $NEO4J_DOWNLOAD_URL -P $DEFAULT_SOURCE_ROOT
	tarIt $DEFAULT_SOURCE_ROOT/$NEO4J_FILE_TAR
	setPermission $DEFAULT_INSTALLATION_DEST/$NEO4J_FILE
cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### NEO4J ###########
  ###############################
  NEO4J_HOME=/usr/local/neo4j-community-1.9.7
  export NEO4J_HOME
  export PATH=$PATH:$NEO4J_HOME/bin
EOF
 reloadProfileConf
}

installCassandra(){
	CASSANDRA_VERSION="2.0.7"
	CASSANDRA_FILE="apache-cassandra-$CASSANDRA_VERSION"
	CASSANDRA_FILE_TAR="$CASSANDRA_FILE-bin.tar.gz"
	CASSANDRA_DOWNLOAD_URL="http://www.dsgnwrld.com/am/cassandra/$CASSANDRA_VERSION/$CASSANDRA_FILE_TAR"
	#wgetIt $CASSANDRA_DOWNLOAD_URL ##comment it out to install from existing tar
	tarIt $DEFAULT_SOURCE_ROOT/$CASSANDRA_FILE_TAR
	setPermission $DEFAULT_INSTALLATION_DEST/$CASSANDRA_FILE
cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### CASSANDRA #########
  ###############################
  CASSANDRA_HOME=/usr/local/apache-cassandra-2.0.7
  export CASSANDRA_HOME
  export PATH=$PATH:$CASSANDRA_HOME/bin
EOF
 reloadProfileConf
}

installRabbitMQ(){
	RABBIT_VERSION="3.2.4"
	RABBIT_TOOL="rabbitmq-server-generic-unix-$RABBIT_VERSION.tar.gz"
	RABBIT_PATH="$DEFAULT_SOURCE_ROOT/JVM/SolrLuceneES-BigData/$RABBIT_TOOL"
	RABBIT_URL="http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.4/$RABBIT_TOOL"
	RABBIT_DEST="rabbitmq_server-3.2.4"
        #wgetIt $RABBIT_URL && tarIt $RABBIT_PATH
	tarIt $RABBIT_PATH
	setPermissionRWE $DEFAULT_DEFAULT_DESTINATION/$RABBIT_DEST
cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### NEO4J ###########
  ###############################
  RABBIT_HOME=/usr/local/rabbitmq_server-3.2.4
  export RABBIT_HOME
  export PATH=$PATH:$RABBIT_HOME/sbin
EOF

 reloadProfileConf
 
 installErlang
}

installEmacs(){

	sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg
}

installImmutant(){
	immutant_version="1.1.1"
	wget http://repository-projectodd.forge.cloudbees.com/release/org/immutant/immutant-dist/1.1.1/immutant-dist-$immutant_version-slim.zip -P ~/.lein

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
