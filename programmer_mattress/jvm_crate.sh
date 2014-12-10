
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
      sudo wget -O /usr/local/bin/lein https://raw.github.com/technomancy/leiningen/stable/bin/lein      
      sudo chmod +x /usr/local/bin/lein 
      lein --version
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
 GRAILS_VERSION="2.4.0"
 GRAILS_DOWNLOAD_URL="http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-${GRAILS_VERSION}.zip"
 GRAILS_LOCATION_SOURCE="$DEFAULT_SOURCE_ROOT/$GRAILS_TOOL-$GRAILS_VERSION.zip"
 
 if [ ! -e $GRAILS_LOCATION_SOURCE ]; then
	   wgetIt $GRAILS_DOWNLOAD_URL
 else 
	   echo "[info] : ${GRAILS_LOCATION_SOURCE} already exists."
 fi

 unzipIt $GRAILS_LOCATION_SOURCE
 setPermissionRWE $DEFAULT_INSTALLATION_DEST/$GRAILS_TOOL-$GRAILS_VERSION

cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### grails #############
  ###############################
  GRAILS_HOME=/usr/local/grails-2.4.0
  export GRAILS_HOME
  export PATH=$PATH:$GRAILS_HOME/bin
EOF

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

installImmutant(){
	immutant_version="1.1.1"
	wget http://repository-projectodd.forge.cloudbees.com/release/org/immutant/immutant-dist/1.1.1/immutant-dist-$immutant_version-slim.zip -P ~/.lein

}

