set -e

installElasticsearch(){
				VERSION_ES="1.1.0"
				ES_HOME=$DEFAULT_INSTALLATION_DEST/elasticsearch-$ES_VERSION
				sudo tar -zxvf $DEFAULT_SOURCE_ROOT_JVM/SolrLuceneES-BigData/elasticsearch-$VERSION_ES.tar.gz -C $DEFAULT_INSTALLATION_DEST
				sudo chmod -R ugo+rw $ES_HOME
          	                $ES_HOME/bin/plugin -i elasticsearch/marvel/latest
}


##zookeper
installZook(){
	ZOOK_VERSION="3.4.5"
	ZOOK_TOOL="zookeeper-${ZOOK_VERSION}"
	ZOOK_DOWNLOAD_URL="http://www.us.apache.org/dist/zookeeper/${ZOOK_TOOL}/${ZOOK_TOOL}.tar.gz"
	
	if [ -e $DEFAULT_INSTALLATION_DEST/${ZOOK_TOOL} ]; then
		echo "${ZOOK_TOOL} alreay installed";
		##return;
	elif [ ! -e $DEFAULT_SOURCE_ROOT/${ZOOK_TOOL}.tar.gz ]; then
                wgetIt $ZOOK_DOWNLOAD_URL
        else
                echo "[info] : $DEFAULT_SOURCE_ROOT/$ZOOK_TOOL already exists"
        fi

	sudo mkdir -p /var/lib/zookeeper
	sudo mkdir -p /var/log/zookeeper

	tarIt "$DEFAULT_SOURCE_ROOT/$ZOOK_TOOL.tar.gz"
	sudo chmod 777 -R $DEFAULT_INSTALLATION_DEST/$ZOOK_TOOL
        cp $DEFAULT_INSTALLATION_DEST/$ZOOK_TOOL/conf/zoo_sample.cfg $DEFAULT_INSTALLATION_DEST/$ZOOK_TOOL/conf/zoo.cfg 
cat >> ~/.bash_profile <<'EOF'
  
  ###############################
  ########### ZOOK ###############
  ###############################
  ZOOK_HOME=/usr/local/zookeper-3.4.5
  export ZOOK_HOME
  export PATH=$PATH:$ZOOK_HOME/bin

EOF

   reloadProfileConf

   echo "####################################################"
   echo "[info] : ${ZOOK_TOOL} is installed successfully."
   echo "####################################################"
}

# https://github.com/nathanmarz/storm/wiki/Setting-up-development-environment
installStorm(){
	#install zook
	installZook
	STORM_VERSION="0.8.2"
	STORM_SOURCE="storm-$STORM_VERSION"
        STORM_DOWNLOAD_URL="https://dl.dropboxusercontent.com/s/fl4kr7w0oc8ihdw/storm-0.8.2.zip"
	#https://dl.dropboxusercontent.com/s/tqdpoif32gufapo/storm-0.9.0.1.tar.gz
	if [ ! -e $DEFAULT_SOURCE_ROOT/${STORM_SOURCE}.zip ]; then
                wgetIt $STORM_DOWNLOAD_URL
        else
                echo "[info] : $DEFAULT_SOURCE_ROOT/$STORM_SOURCE already exists"
        fi

	unzipIt "$DEFAULT_SOURCE_ROOT/JVM/SolrLuceneES-BigData/$STORM_SOURCE.zip"
	sudo chmod 777 -R $DEFAULT_INSTALLATION_DEST/$STORM_SOURCE

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
	setPermissionRWE $DEFAULT_INSTALLATION_DEST/$RABBIT_DEST
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


installHadoop(){
	HADOOP_VERSION="2.2.0"
	HADOOP_TOOL="hadoop-$HADOOP_VERSION.tar.gz"
	HADOOP_PATH="$DEFAULT_SOURCE_ROOT/$HADOOP_TOOL"
	HADOOP_URL="http://www.eng.lsu.edu/mirrors/apache/hadoop/common/hadoop-$HADOOP_VERSION/$HADOOP_TOOL"
	HADOOP_DEST="hadoop-$HADOOP_VERSION"
        #wgetIt $HADOOP_URL
	tarIt $HADOOP_PATH
	setPermissionRWE $DEFAULT_INSTALLATION_DEST/$HADOOP_DEST
cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### HADOOP ############
  ###############################
  HADOOP_HOME=/usr/local/hadoop-2.2.0
  export HADOOP_HOME
  export PATH=$PATH:$HADOOP_HOME/bin
EOF

 reloadProfileConf
 
}

