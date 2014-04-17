##########################################################################
######## https://github.com/gf3/dotfiles/blob/master/bootstrap.sh ########
##########################################################################

##BACKUP

backup="~/backup"
backupDotfiles(){
 mkdir $backup
 mv ~/.vim $backup
 mv ~/.vimrc $backup
 mv ~/.bashrc $backup
 mv ~/.gitconfig $backup
 mv ~/.bash_profile $backup
}

installDotfiles(){
 cp -r .vim ~/
 cp .vimrc ~/
 cp .bash_profile ~/
 cp .bashrc ~/
 cp .gitconfig ~/
 cp .tmux.conf ~/
 cp .bash_aliases ~/
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

init(){
 backupDotfiles
 installDotfiles
 askForGitconfigUser
 configureGitDiff
 installVundleDeps
 gconftool --type string --set /desktop/gnome/background/primary_color "#002b36"
 echo "#####################################$$$$$$#######"
 echo "#####[info] : dotfiles installed \,,/#############"
 echo "##################################################"
}

##main
init
