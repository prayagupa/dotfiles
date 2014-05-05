##TODO move these to configuration.sh
CODE_SPACE="/packup/workspace.programming"
MUSIC_SPACE="/packup/repo.music.audio_"
WORKSPACE="$HOME/backup/hacker_/w.groovy/"

########################################################################################
######################################                 #################################
######################################  [git aliases]  #################################
######################################                 #################################
########################################################################################
alias gs='git status'
alias ga='git add'
alias gCommit='git commit'
alias gClone='git clone'

##stash'ing
alias gStash='git stash'
##git stash show in diff style
alias gStashShow='git stash show -p'
alias gStashPop='git stash pop'

#incoming stat
alias gIncomingMasterStat='git fetch && git log ..origin/master --stat'
alias gIncomingDevelopStat='git fetch && git log ..origin/develop --stat'

alias gOutgoingDevelopStat='git fetch && git log origin/develop.. --stat'

#incoming patch
alias gIncomingMasterPatch='git fetch && git log ..origin/master --patch'
alias gIncomingDevelopPatch='git fetch && git log ..origin/develop --patch'

#analyse commit
alias gShow='git show'

alias gPushMaster='git push origin master -v'
alias gPushDevelop='git push origin develop -v'

alias gPullMaster='git pull origin master -v'
alias gPullDevelop='git pull origin develop -v'

alias gDiff='git diff'
alias gCheckout='git checkout'

alias glpd="git log --graph --all --decorate --pretty=format:'%h %ad %s (%an)' --date=short"

#refactor
alias gRemove='git rm -r'

########################################################################################
#########################
#########################     other personal aliases
#########################
########################################################################################

alias goMakalu='cd $WORKSPACE/DasBackend/DasTest && git status'
alias letscode='cd $CODE_SPACE'
alias letsmusic='cd $MUSIC_SPACE/METAL && ls -l'

alias androidStudioStart='/usr/local/android-studio/bin/studio.sh > /usr/local/android-studio/studio.log &'

alias enoughCoding='sudo shutdown -h now'
##while sleeping
alias musicalSleep='sudo shutdown -h 60'
