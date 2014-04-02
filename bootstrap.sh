##Sensors Indicator
##http://www.noobslab.com/2013/04/panel-indicators-collection-for-ubuntu.html
#sudo add-apt-repository ppa:noobslab/indicators
#sudo apt-get update
#sudo apt-get install -y indicator-sensors lm-sensors

##

installMysqlDependency(){
 sudo apt-get install libmysqlclient-dev
}


#####################################################################################
############################# golang ################################################
#####################################################################################

installGoLang(){

cat >>  ~/.bash_profile << EOF
  export GOROOT=$HOME/go
  export GOOS=linux      # target operating system
  export GOARCH=386      # target compiling architecture
  PATH=$PATH:$GOROOT/bin 
EOF

sudo apt-get install git mercurial
wget http://go.googlecode.com/files/go1.1.1.linux-amd64.tar.gz
tar xf go1.1.1.linux-amd64.tar.gz
#rm go1.1.1.linux-amd64.tar.gz
source ~/.bash_profile
}
