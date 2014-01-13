#Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tom/.zshrc'

#Modify PATH to allow for use of LaTeX
PATH=/usr/local/texlive/2013/bin/x86_64-linux:$PATH; export PATH
MANPATH=/usr/local/texlive/2013/texmf-dist/doc/man:$MANPATH; export MANPATH
INFOPATH=/usr/local/texlive/2013/texmf-dist/doc/info:$INFOPATH; export INFOPATH
PATH=/home/tom/bin:$PATH; export PATH

#Set up git prompt
source $HOME/programming/git-repos/zsh-git-prompt/zshrc.sh

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Following lines were added by me
# PS1='%B%n@%m:%b %2.%# '
PS1='%B%n@%m$%b '
# See IBM's tutorial on the Z shell for explanation of the following
# http://www.ibm.com/developerworks/linux/library/l-z.html?dwzone=linux
setopt AUTO_LIST AUTO_MENU
setopt AUTO_CD
RPROMPT='%/$(git_super_status)'
#
#Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias -s otl=vim
alias -s tex=vim
alias -s pdf=evince
alias -s html=w3m
alias -g xterm='xterm -r'
alias -g reallyLongCommandForTask='task list'
#alias -g hgreposTom='ssh root@192.168.0.103 ls -al /var/lib/mercurial-server/repos/tom'
#alias -g hgreposRebekah='ssh root@192.168.0.103 ls -al /var/lib/mercurial-server/repos/rebekah'

#Shortcuts for directories
hash -d media=/home/tom/multimedia
hash -d passMedia=/media/passport/multimedia
hash -d video=/media/passport/multimedia/video/backMeUp
hash -d comics=/home/tom/network/myBook/multimedia/books/Comics
hash -d ctt=/home/tom/programming/python/cttoverview
hash -d install=/home/tom/programming/python/installscript
hash -d viz=/home/tom/programming/processing/visualizing
hash -d cttOverview=/home/tom/programming/python/projects/cttOverviewWorking
hash -d cttOverviewRepo=/home/tom/network/elements01/programming/python/cttOverviewWorking
hash -d clusterdata=/home/tom/programming/python/projects/clusterdata

#Load completion stuff for Taskwarrior
fpath=($fpath /usr/local/share/doc/task/scripts/zsh/)
autoload -Uz compinit
compinit

# be verbose, i.e. show descriptions
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

# group by tag names
zstyle ':completion:*' group-name ''

#Make backward history search work with vi keybindings
bindkey '^R' history-incremental-search-backward

#Functions
#Check for current repos
#hgrepos () {
	#ssh root@192.168.0.$1 ls -al /var/lib/mercurial-server/repos/$2
#}

#vidsearch () {
	#less /home/tom/multimedia/Video/VideoIssues | grep $1
#}

#Start up the Galaxy box with ntfs support
#lb () {
#	[[ -b /dev/sdd1 ]] && sudo mount -t ntfs-3g /dev/sdd1 /mnt/win || print "Box not where expected"
#	mc /home/tom/multimedia/Video /mnt/win/Movies
#}	

#A command line calculator
calc () {
	echo "$*" | bc -l;
}

#Shows how much space each directory is taking up
howbig () {
	du -h $1 | grep '^[0-9.]*G' | sort -n
}

#Checks for filesystem that is over 90% full
toomuch () {
	df -k | egrep -v "proc|fd|cdrom|mnttab|run|tmp|Filesystem" | sed 's/\%//' | awk '$5 >= 90 {print $5 "%\t" $6}'
}

#Uses Task Warrior to set up current To Do List
gtd () {
	clear && task calendar && task active
	remind -s+1 ~/.reminders
}

#Uses Task Warrior to show calendar and all tasks
gtdUb () {
	clear && task calendar && task unblocked rc.annotations:none
}

#Print a calendar and list Next Actions only without the Top Tasks
#This depends on a definition of a basic task report as follows (add this to the .taskrc file):
#report.basic.columns=id,project,tags.indicator,urgency,description.count
#report.basic.sort=urgency-

na () {
	clear && task calendar && task basic status:pending
	#rem
	#remind -s+1gaa ~/.reminders
}

#List Top Tasks
toptask () {
	task list tag.has:topTask
}

#Sync the Taskwarrior data to EEEPC
taskSync () {
	rsync -avz /media/truecrypt3/.task/ tom@$1:/media/truecrypt3/.task
}

#Get Someday tasks
someday () {
	task waiting | grep 1/18/2038
}

#Get WaitingFor tasks
waitingFor () {
	task ls tags.contains:waitingFor
}

#Pending for project
#Look for non-complete tasks for a given project
projnc () {
	task all project:$1 | grep "^[0-9, ][0-9]"
}

#Mount Pogo myBook drive with sshfs to network/myBook
pogoMyBook () {
	sshfs tom@192.168.0.$1:/media/myBook /home/tom/network/myBook
}

#Mount Pogo home directory with sshfs on network/serverMain
pogoHome () {
	sshfs tom@192.168.0.$1:/home/torrent /home/tom/network/serverMain
}

pogoShares () {
	print "Warning: this will fail if the /etc/hosts file is not up to date (i.e. if the alarm address is wrong)"
	sshfs tom@alarm:/media/myBook /home/tom/network/myBook
	print "Mounted pogo:myBook to network/myBook"
	sshfs tom@alarm:/home/torrent /home/tom/network/serverMain
	print "Mounted pogo:torrent to network/serverMain"
}

#Start DIVE CD server
dive () {
	cd /home/tom/network/myBook/multimedia/video/Saxon
	python -m SimpleHTTPServer &
	cd
}

#Looking for Janet's 2009 consults
#Put in the type of consult (Surgery, Bone, Gyn, etc.) as the argument
zebraconsults () {
	grep ^Subject ./* | grep $1 | grep -v '[Rr][Ee]' | grep -v '[Ff][Ww]' | less &&
	grep ^Subject ./* | grep $1 | grep -v '[Rr][Ee]' | grep -v '[Ff][Ww]' | wc -l

}

zebrathreads () {
	grep ^Subject ./* | grep $1 | less
}
	

#Set up virtualenv to work with Django development
#Suggested at http://www.jeffknupp.com/blog/2012/10/24/starting-a-django-14-project-the-right-way/
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/programming/python/django
source /usr/local/bin/virtualenvwrapper.sh


