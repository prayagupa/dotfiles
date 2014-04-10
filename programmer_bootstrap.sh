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

cljInstall(){
      curl https://raw.github.com/technomancy/leiningen/stable/bin/lein > lein
      sudo mv lein /usr/bin/
      sudo chmod +x /usr/bin/lein 
      #lein repl
}

scalaInstall(){
 SCALA_VERSION="2.10.3"
 SCALA_LOCATION_SOURCE="/packup/repo.softwares/JVM/scala/scala$SCALA_VERSION.tgz"
 
 SCALA_LOCATION_DESTINATION="/usr/local/"
 
 sudo tar -zxvf $SCALA_LOCATION_SOURCE -d $SCALA_LOCATION_DESTINATION
 #sudo mv $SCALA_LOCATION_SOURCE  $SCALA_LOCATION_DESTINATION

 ls -l $SCALA_LOCATION_DESTINATION

 sudo chmod 777 -R /usr/local/scala-$SCALA_VERSION

 cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### SCALA #############
  ###############################
  JAVA_HOME=/usr/local/scala-2.10.3
  export JAVA_HOME
  export PATH=$PATH:$JAVA_HOME/bin
EOF

 source ~/.bash_profile

 echo "###########################################"
 echo "jdk $SCALA_VERSION is installed successfully."
 echo "###########################################"

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
  /usr/local/android-studio/bin/studio.sh > /usr/local/android-studio/studio.log &
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

installElasticsearch(){
				sudo tar -zxvf /packup/repo.softwares/JVM/Solr-Lucene-ES\(Big\ Data\)/elasticsearch-1.0.0.tar.gz -C /usr/local/
				sudo chmod -R ugo+rw /usr/local/elasticsearch-1.0.0/
}

installMysql(){
				sudo apt-get install mysql-server
}

init(){
    installGit
    cljInstall
    jdkInstall
    installElasticsearch
    installMysql
}

#init
