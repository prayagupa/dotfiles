#!/bin/bash

#DEFAULT_SOURCE_ROOT="/packup/repo.softwares"
DEFAULT_SOURCE_ROOT="$HOME/backup/JVM"
DEFAULT_SOURCE_ROOT_JVM="/packup/repo.softwares/JVM"
DEFAULT_INSTALLATION_DEST="/usr/local/"

#########################################################################
##global functions
#########################################################################

reloadProfileConf(){
   echo ""
   echo "[info] : reloading $HOME/.bash_profile."	
   echo ""
   source ~/.bash_profile
}

unzipIt(){
   echo ""
   echo "[info] : unzipping $1 to $DEFAULT_INSTALLATION_DEST."
   echo ""
   sudo unzip $1 -d $DEFAULT_INSTALLATION_DEST
}

gunzipIt(){
   echo ""
   echo "[info] : gunzipping $1 to $DEFAULT_INSTALLATION_DEST."
   echo ""

   sudo tar xjf $1  -C $DEFAULT_INSTALLATION_DEST
}

## .tgz
tarIt(){
   echo ""
   echo "[info] : tarring $1 to $DEFAULT_INSTALLATION_DEST."
   echo ""

   sudo tar -zxvf $1  -C $DEFAULT_INSTALLATION_DEST
}

setPermissionRWE(){
				sudo chmod -R 777 $1

}

setPermission(){
				sudo chmod -R ugo+rw $1
}

wgetIt(){
   echo "[info] : wgetting $1 to $DEFAULT_SOURCE_ROOT."	
   echo ""
   wget $1 -P $DEFAULT_SOURCE_ROOT

   echo ""
   echo "[info] : wgetting $1 to $DEFAULT_SOURCE_ROOT finished."	
   echo ""
}

showMessage(){
 echo "##################################################"
 echo "[info] : $1 $2 is installed successfully."
 echo "##################################################"
}
#########################################################################

