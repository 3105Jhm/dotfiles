#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias gairon-copy='source ~aotani.t.aa/local/bin/gairon-copy.sh'
alias dte='~/dte-1.6/dte'
alias nvim='~/nvim-osx64/bin/nvim'

export EDITOR=nvim
export VISUAL=nvim
export GOPATH=~/go
export PATH="$PATH:$GOPATH/bin:$HOME/.local/bin"

RED=$(tput setaf 1)
BOLD=$(tput bold)
RESET=$(tput sgr0)

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	diverged=`echo -n "${status}" 2> /dev/null | grep "have diverged" &> /dev/null; echo "$?"`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	bits=''
	if [ "${ahead}" == "0" ]; then
		bits="|${bits}"
	elif [ "${diverged}" == "0" ]; then
		bits="Y${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="*${bits}"
	elif [ "${renamed}" == "0" ]; then
		bits="*${bits}"
	elif [ "${newfile}" == "0" ] && [ "${deleted}" == "0" ]; then
		bits="*${bits}"
	elif [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	elif [ "${deleted}" == "0" ]; then
		bits="-${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function set_color {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RED"
}

export PS1="\[\`set_color\`$BOLD\]\u@\h \w\`parse_git_branch\`\\$\[$RESET\] "
