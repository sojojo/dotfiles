# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Sojo custom terminal color scheme
declare -A colr
colr=(
['def']="\[\033[00m\]"
['lbl']="\[\033[38;05;81m\]"
['org']="\[\033[38;05;172m\]"
['grn']="\[\033[38;05;190m\]"
['red']="\[\033[38;05;160m\]"
['gry']="\[\033[38;05;238m\]"
['lgy']="\[\033[38;05;249m\]"
)

base() {
  name="$1"
  len=`expr length $name`
  echo $len
  diff=$(( 15-$len ))
  printf "%"$diff"."$diff"s\n" $1
}
source ~/.git-prompt.sh
if [ "$color_prompt"=yes ]; then
    # format so that the prompt is right justified a certain amount
    p2=`printf "%15.15s\n" "${PWD##*/}"`
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'
    PS1="${debian_chroot:+($debian_chroot)}${colr['lbl']}\u@\h:\e[1m\w\e[21m"
    PS1="$PS1 ${colr['gry']}\@"
    PS1="$PS1 ${colr['grn']}\$(__git_ps1 '(%s)')${colr['def']}:${colr['gry']}\n"
    PS1="$PS1 \W\$${colr['lgy']} "
    # PS1="$PS1$(base '\W')\$${colr['lgy']} "
    # PS1="$PS1`printf '%%$[15-${#'${PWD##*/}'}].$[15-${#'${PWD##*/}'}]s' '\W'`\$${colr['lgy']} "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w \$(__git_ps1 "(%s)") \$ '
fi
unset color_prompt force_color_prompt

# Sojojo - If we're doing SSH, change coloration
if [ -n "$SSH_CLIENT" ]; then
    clear
    echo "Now accessing Sojojo's RocketSpace computer via SSH."
    echo "Please wipe your feet before entering.."; echo; echo
    # invert prompt
    # PS1="\e[7m$PS1\e[0m"
    PS1="${colr['red']}\e[1mSojoSSH\e[0m $PS1"
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export PATH=$PATH:~/.npm/less/1.3.3/package/bin
export PATH=$PATH:~/.npm/clean-css/0.9.1/package/bin
export PATH=$PATH:~/.npm/uglify-js/1.3.3/package/bin

# Personal Sojo

rocketup(){
  scp "$@" sojojo@rocket.sojojoid.com:~/Downloads
}
rocketdl(){
  filedl=sojojo@rocket.sojojoid.com:~/Downloads/$@
  scp $filedl .
}
rocketls(){
  ssh sojojo@rocket.sojojoid.com "ls -a ./Downloads"
}
source ~/.private/wt

export TERM="xterm-256color"
