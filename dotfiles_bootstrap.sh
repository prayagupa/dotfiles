##########################################################################
######## https://github.com/gf3/dotfiles/blob/master/bootstrap.sh ########
##########################################################################


##BACKUP
backup="$HOME/dotfiles_backup"
backupDotfiles(){
 echo ""
 echo "Backing up your dotfiles to $backup."
 echo ""

 mkdir "$backup"
 mv ~/.vim "$backup"
 mv ~/.vimrc "$backup"
 mv ~/.bashrc "$backup"
 mv ~/.gitconfig "$backup"
 mv ~/.bash_profile "$backup"
 mv ~/.emacs.d "$backup"

 echo ""
 echo "Backing up your dotfiles to $backup is successful."
 echo ""
}

installDotfiles(){
 cp -r .vim ~/
 cp .vimrc ~/
 cp .bash_profile ~/
 cp .bashrc ~/
 cp .bash_prompt ~/
 cp .gitconfig ~/
 cp .tmux.conf ~/
 cp .bash_aliases ~/

 cp -r .emacs.d ~/

 cp -r .lein ~/

 git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle && git clone https://github.com/altercation/vim-colors-solarized ~/.vim/bundle/vim-colors-solarized

 git clone https://github.com/sellout/emacs-color-theme-solarized.git ~/.emacs.d/emacs-color-theme-solarized
}

configureGitDiff(){
 #sudo touch /usr/local/bin/git_diff_wrapper
 sudo tee -a /usr/local/bin/git_diff_wrapper  >/dev/null << 'EOF'
				#!/bin/sh
				vimdiff "$2" "$5"
EOF
 sudo chmod 777 /usr/local/bin/git_diff_wrapper
}

askForGitconfigUser(){

   echo -n "git username (eg. iPrayag): "
   read username

   echo -n "git email (eg. prayag.upd@gmail.com) : "
   read email

cat >> ~/.gitconfig <<EOF 
   [user]
	name  = $username
	email = $email
EOF
}

installVundleDeps(){
  vim +BundleInstall +qall
}

installEmacs(){
        sudo add-apt-repository ppa:cassou/emacs
	sudo apt-get update
	sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg
}

# @see : http://linuxg.net/how-to-install-vim-7-4-on-ubuntu-13-10-13-04-12-04-linux-mint-16-15-13-and-debian-sid/
# VIm 7.4
installVIm(){
	sudo add-apt-repository ppa:fcwu-tw/ppa
	sudo apt-get update
	sudo apt-get install vim
}

installXLibs(){
	sudo apt-get install lua5.1
	#for YouCompleteMe vim plugin
	# https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64-super-quick-installation
	sudo apt-get install build-essential cmake
	sudo apt-get install python-dev
	#cd ~/.vim/bundle/YouCompleteMe/
	#./install.sh
}

init(){
 backupDotfiles
 installDotfiles
 askForGitconfigUser
 configureGitDiff
 installVIm
 installXLibs
 installVundleDeps
 gconftool --type string --set /desktop/gnome/background/primary_color "#002b36"

 installEmacs

 sudo apt-get install tmux
 echo ""
 echo "####################################################"
 echo "###### [info] : dotfiles installed \,,/ ############"
 echo "####################################################"
}

update(){
  echo ""
  echo "#########################################################"
  echo "################ Updating .bash_aliases, .vimrc  ########"
  echo "#########################################################"

  mkdir $HOME/dotfiles_backup_u
  mv ~/.vimrc $HOME/dotfiles_backup_u
  mv ~/.bash_aliases $HOME/dotfiles_backup_u
  cp .vimrc ~/
  cp .bash_aliases ~/
  installVundleDeps

  echo ""
  echo "#########################################################"
  echo "################## dotfiles UPDATED #####################"
  echo "#########################################################"
}

##main
start(){
echo -n "######################################################## "
echo
echo -n "#################### select options #################### "
echo
echo -n "######################################################## "
echo
echo -n "INSTALLATION  - i "
echo
echo -n "UPDATE        - u (.vimrc, .bash_aliases)"
echo
read option

if [ 'i' == $option ] 
then
	init
elif [ 'u' == $option ] 
then
        update
else
	echo "WTF !!! "
fi
}

start
