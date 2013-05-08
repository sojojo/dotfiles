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

source ~/.git-prompt.sh
if [ "$color_prompt"=yes ]; then
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'
    PS1="${debian_chroot:+($debian_chroot)}${colr['lbl']}\u@\h:\e[1m\w\e[21m"
    PS1="$PS1 ${colr['gry']}\@"
    PS1="$PS1 ${colr['grn']}\$(__git_ps1 '(%s)')${colr['def']}:\n"
    PS1="$PS1  ${colr['gry']}\W \$${colr['lgy']} "
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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
source ~/.private/wt

alias macaddr='ifconfig | grep "HWaddr"'
alias ipaddr='ifconfig | grep "inet addr" -B 1'
alias diff='vim -d'  # use vim for diff
alias install='sudo apt-get install'
alias update='sudo apt-get update && sudo apt-get upgrade'
#alias mailme='mail -s mailthis pasjoman@gmail.com < '
# find things in python specifically
alias greppy="find . | grep [.]py$ | xargs grep " # search within py
alias go='xdg-open' # opens dir/file with registered application
alias findy='find . -name'
alias targz='tar -xzvf'

# useful aliases from others

#ls
## Use a long listing format ##
alias ll='ls -la'
## Show hidden files ##
alias l.='ls -d .* --color=auto'

#cd
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

# calculator
alias calc='bc -l'

# system..
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
# stats
## pass options to free ##
alias meminfo='free -m -l -t'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
## Get server cpu info ##
alias cpuinfo='lscpu'
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# network
alias ports='netstat -tulanp'
alias reboottomato="ssh admin@192.168.1.1 /sbin/reboot"
alias wakeupnas01='/usr/bin/wakeonlan 00:11:32:11:15:FC' # wake on lan
## shortcut  for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'
# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

export TERM="xterm-256color"
