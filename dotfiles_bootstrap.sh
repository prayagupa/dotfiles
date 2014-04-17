##########################################################################
######## https://github.com/gf3/dotfiles/blob/master/bootstrap.sh ########
##########################################################################

##BACKUP
backup="~/backup"
mkdir $backup
mv ~/.vim $backup
mv ~/.vimrc $backup
mv ~/.bashrc $backup
mv ~/.gitconfig $backup
mv ~/.bash_profile $backup

cp -r .vim ~/
cp .vimrc ~/
cp .bash_profile ~/
cp .bashrc ~/
cp .gitconfig ~/
cp .tmux.conf ~/
cp .bash_aliases ~/


configureGitDiff(){
#sudo touch /usr/local/bin/git_diff_wrapper
sudo tee -a /usr/local/bin/git_diff_wrapper  >/dev/null << 'EOF'
				#!/bin/sh
				vimdiff "$2" "$5"
EOF
sudo chmod 777 /usr/local/bin/git_diff_wrapper
}

configureGitDiff

