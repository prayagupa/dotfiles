########################################################################################
#########################
#########################     git aliases
#########################
########################################################################################
alias gs='git status'
alias ga='git add'
alias gco='git commit'

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

########################################################################################
#########################
#########################     other aliases
#########################
########################################################################################

alias goMakalu='cd ~/backup/makaluSeries/makalu_develop/DasTest && git status'
alias androidStudioStart='/usr/local/android-studio/bin/studio.sh > /usr/local/android-studio/studio.log &'
