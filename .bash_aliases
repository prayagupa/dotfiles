########################################################################################
#########################
#########################     git aliases
#########################
########################################################################################
alias gs='git status'
alias ga='git add'
alias gco='git commit'
alias gClone='git clone'

#incoming stat
alias gIncomingMasterStat='git fetch && git log ..origin/master --stat'
alias gIncomingDevelopStat='git fetch && git log ..origin/develop --stat'

#incoming patch
alias gIncomingMasterPatch='git fetch && git log ..origin/master --patch'
alias gIncomingDevelopPatch='git fetch && git log ..origin/develop --patch'

alias gPushMaster='git push origin master -v'
alias gPushDevelop='git push origin develop -v'

alias gPullMaster='git pull origin master -v'
alias gPullDevelop='git pull origin develop -v'

alias gDiff='git diff'
alias gCheckout='git checkout'

alias glpd="git log --graph --all --decorate --pretty=format:'%h %ad %s (%an)' --date=short"

########################################################################################
#########################
#########################     other personal aliases
#########################
########################################################################################

alias goMakalu='cd ~/backup/makaluSeries/makalu_develop/DasTest && git status'
alias letscode='cd /packup/workspace.programming'
alias music='cd /packup/repo.music.audio_/METAL'

alias androidStudioStart='/usr/local/android-studio/bin/studio.sh > /usr/local/android-studio/studio.log &'

alias enoughCoding='sudo shutdown -h now'
##while sleeping
alias musicalSleep='sudo shutdown -h 60'
