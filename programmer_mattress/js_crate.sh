#!/bin/sh

##################################
#source utils.sh
#source $(dirname $0)/utils.sh
## js crate ######################

installNodeJS(){
	#NODEJS_VERSION="0.8.1"
	NODEJS_VERSION="0.10.28"
	NODEJS_TOOL="node-v0.10.28-linux-x64.tar.gz"
	#NODEJS_TOOL="node-v$NODEJS_VERSION.tar.gz"
	NODEJS_URL="http://nodejs.org/dist/v$NODEJS_VERSION/$NODEJS_TOOL"
	#TODO check if tar.gz exists
	wgetIt $NODEJS_URL
	NODEJS_PATH=$DEFAULT_SOURCE_ROOT/$NODEJS_TOOL
	NODEJS_DEST="$DEFAULT_INSTALLATION_DEST/node-v$NODEJS_VERSION-linux-x64"
	tarIt $NODEJS_PATH
        setPermissionRWE $NODEJS_DEST
cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### NODE ############
  ###############################
  NODE_HOME=/usr/local/node-v0.10.28-linux-x64
  export NODE_HOME
  export PATH=$PATH:$NODE_HOME/bin
EOF

 reloadProfileConf

}

installPhantomJS(){
	PHANTOM_VERSION="1.9.7"
	PHANTOM_TOOL="phantomjs-$PHANTOM_VERSION-linux-x86_64.tar.bz2"
	PHANTOM_URL="https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_TOOL"
	if [ ! -e $DEFAULT_SOURCE_ROOT/$PHANTOM_TOOL ]; then
                wgetIt $PHANTOM_URL
        else
                echo "[info] : $DEFAULT_SOURCE_ROOT/$PHANTOM_TOOL exists"
        fi
	gunzipIt $DEFAULT_SOURCE_ROOT/$PHANTOM_TOOL
	sudo ln -s /usr/local/phantomjs-$PHANTOM_VERSION-linux-x86_64 /usr/local/phantomjs
	sudo ln -s /usr/local/phantomjs/bin/phantomjs /usr/local/bin/phantomjs
}

installGoogleClosure(){
	CLOSURE_TOOL="compiler-20131014.zip"
	CLOSURE_URL="https://closure-compiler.googlecode.com/files/$CLOSURE_TOOL"
	if [ ! -e $DEFAULT_SOURCE_ROOT/$PHANTOM_TOOL ]; then
	   wgetIt $CLOSURE_URL
        else 
		echo "[info] : $DEFAULT_SOURCE_ROOT/$CLOSURE_PATH already exists."
	fi
        unzipIt $DEFAULT_SOURCE_ROOT/$CLOSURE_TOOL

	mkdir $DEFAULT_DESTINATION_DEST/build
	sudo mv $DEFAULT_DESTINATION_DEST/compiler.jar $DEFAULT_DESTINATION_DEST/build

cat >> ~/.bash_profile <<'EOF'
  ###############################
  ########### CLOSURE #############
  ###############################
  CLOSURE_PATH=/usr/local/build
  export CLOSURE_PATH
  export PATH=$PATH:$CLOSURE_PATH/
EOF

}
