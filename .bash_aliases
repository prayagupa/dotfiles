
########################################################################################
######################################                 #################################
######################################  [git aliases]  #################################
######################################                 #################################
########################################################################################
alias gs='git status'
alias ga='git add'
alias gaUndo='git reset' #gaUndo [file]
alias gResetLocalChangesMaster='git reset --hard origin/master'
alias gResetLocalChangesDevelop='git reset --hard origin/develop'
alias gCommit='git commit'
alias gCommitAfterMergeWithNoFiles='git commit'
alias gClone='git clone'
alias gBranchNameCurrent='git rev-parse --symbolic-full-name --abbrev-ref HEAD'

##stash'ing
alias gStash='git stash'
##git stash show in diff style
alias gStashShow='git stash show -p'
alias gStashPop='git stash pop'
alias gStashDrop='git stash drop'

#incoming stat
alias gIncomingMasterStat='git fetch && git log ..origin/master --stat'
alias gIncomingDevelopStat='git fetch && git log ..origin/develop --stat'

alias gOutgoingDevelopStat='git fetch && git log origin/develop.. --stat'
alias gOutgoingMasterStat='git log --pretty=oneline --abbrev-commit --graph @{u}.. --stat'

alias gWhatChangedMasterStat='git whatchanged origin/master.. --stat'
alias gWhatChangedDevelopStat='git whatchanged origin/develop.. --stat'

#incoming patch
alias gIncomingMasterPatch='git fetch && git log ..origin/master --patch'
alias gIncomingDevelopPatch='git fetch && git log ..origin/develop --patch'

#analyse commit
alias gShow='git show'

alias gPushMaster='git push origin master -v'
alias gPushDevelop='git push origin develop -v'

alias gPullMaster='git pull origin master -v'
alias gPullDevelop='git pull origin develop -v'

alias gPullCurrentBranch='git pull origin "$(git rev-parse --symbolic-full-name HEAD)" -v'
alias gPullAllBranches='git pull'

alias gDiff='git diff --word-diff="color"'
alias gCheckout='git checkout'

#branching
alias gBranchesLocal='git branch'
alias gBranchesRemote='git branch -r'

alias gSwitchBranch='git checkout'
alias gSwitchBranchToMaster='git checkout master'
alias gCreateLocalBranch='git checkout -b'
alias gPushLocalBranch='git push -u origin' #usage gPushLocalBranch_ branchName
alias gDeleteLocalBranch='git branch -d'    #usage gDeleteLocalBranch branchName
alias gDeleteRemoteBranch='git push origin --delete'  #usage gDeleteRemoteBranch cashless-spring-security 
alias gRemoteUpdate='git remote update'
alias gMergeBranchWithLatestChanges='git pull && git merge' #eg. staying on main branch(say develop), gMergeBranch origin/cashless-spring-security

alias gConflictedFiles='git diff --name-only --diff-filter=U'

#gRemoteAddUpstream https://github.com/iPrayag/dotfiles.git
#update your fork
alias gRemoteAddUpstream='git remote add upstream'

#eg. staying on main branch(say develop), gMergeBranch origin/cashless-spring-security
alias gMergeChildBranch='git merge' 
#eg. git rebase master, on origin/hulaki-infant
#@see : http://stackoverflow.com/a/5340773/432903
alias gRebaseFromParentBranch='git rebase' 

#@see : http://stackoverflow.com/a/5188364/432903
alias gBranchesCommiterDateMessages='git branch -vv'
alias gBranchesCommiterDate='git for-each-ref --sort=-committerdate refs/heads/'
alias gBranchesCommiterDateFormat='git for-each-ref --sort=-committerdate refs/heads/ --format="%(authordate:short)%09%(objectname:short)%09%1B[0;33m%(refname:short)%1B[m%09"'
alias gBranchesCommiterDatePretty='for ref in $(git for-each-ref --sort=-committerdate --format="%(refname)" refs/heads/ refs/remotes ); do git log -n1 $ref --pretty=format:"%Cgreen%cr%Creset %C(yellow)%d%Creset %C(bold blue)<%an>%Creset%n" | cat ; done | awk '"'! a["'$0'"]++'"

#eg. gRenameBranch <oldname> <newname>
alias gRenameBranch="git branch -m"
#eg. gRenameCurrentBranch -m <newname>
alias gRenameCurrentBranch="git branch -m"

##log
alias glpd="git log --graph --all --decorate --pretty=format:'%Cred%h%Creset %Cgreen(%ad)%Creset %s %Cblue(%an)%Creset' --date=short"
alias glpdr="git log --graph --pretty=format:'%Cred%h%Creset %an -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
#@see:https://github.com/cypher/dotfiles/blob/master/gitconfig

#refactor
alias gRemove='git rm -r'
alias gCheckoutToSpecificCommit='git checkout -b' ##gCheckoutToSpecificCommit BRANCH_NAME 0d1d7fc32

#patches
## @see : http://stackoverflow.com/a/16172120/432903
#
alias gCreatePatch='git format-patch' #@ref : http://stackoverflow.com/a/23340391/432903
alias gCreatePatcheLast10Commits='git format-patch -10 HEAD --stdout > last-10-commits.patch'
alias gApplyPatches='git apply --stat' #eg. gApplyPatch  gccount/patches/high_riskscore.patch


########################################################################################
#########################
#########################     other personal aliases
#########################
########################################################################################

alias lh='ls -lh'
alias fileSpaceUsage='du --max-depth=1 -h'
alias fileSpaceUsageSort='du -sm * | sort -n | tail -n 20'

alias goMakalu='cd $WORKSPACE/MakaluDevelop/DasTest && git status'
alias letscode='cd $CODE_SPACE'
alias letsmusic='cd $MUSIC_SPACE/METAL && ls -l'

alias androidStudioStart='/usr/local/android-studio/bin/studio.sh > /usr/local/android-studio/studio.log &'

alias reboot='sudo reboot'
alias enoughCoding='sudo shutdown -h now'
##while sleeping
alias musicalSleep='sudo shutdown -h 60'
alias soundcardCheck='sudo aplay -l'

alias findPort='sudo lsof -iTCP -sTCP:LISTEN | grep' #findPort amqp
alias trash='sudo rm -rf ~/.local/share/Trash/*'

alias dpkgInstall='sudo dpkg -i'
alias diskspaceUsage='df -h'

alias kernelVersion='uname -r'
alias kernelBit='uname -m'


alias checkProxy='env | grep -i proxy'

#VBox
# @see : http://forum.linuxcareer.com/threads/1782-Virtualbox-check-virtual-machine-status-from-command-line
alias vBoxListVMs='VBoxManage list vms'
alias vBoxRunningVMs='vboxmanage list runningvms'
# @see : http://www.edwardstafford.com/2009/11/08/how-to-using-vboxmanage-to-delete-a-virtual-machine-from-virtualbox/
alias vBoxShowVmInfo='VBoxManage showvminfo'
alias vBoxShowHDDs='VBoxManage list hdds'
# @see : https://groups.google.com/forum/#!topic/pallet-clj/NA6yTHq7LN4
alias vBoxBridgeDifsName='VBoxManage list bridgedifs | grep ^Name'
alias vBoxBridgeDifs='VBoxManage list bridgedifs'
alias vBoxRunningVmIps="VBoxManage guestproperty enumerate {`VBoxManage list runningvms | awk -F'{' '{print $2}'` | grep IP | awk -F',' '{print $2}' | awk '{print $2}'"

#@see : http://prayag-waves.blogspot.com/2013/10/linux-hacks-part-2.html
alias findFile='find . -name'
alias grepInFiles='grep -r'

#nodejs
alias npmLs='npm ls'

alias ip="ifconfig eth0| grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'"

alias sshVbox='ssh vmfest@192.168.56.104'

alias publicSSHKey='cat ~/.ssh/id_rsa.pub'
