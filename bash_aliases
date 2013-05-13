# Some nifty aliases that I've found and made


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
# Sojojo - mostly my stuff

alias favorites='alias | grep "go\|rocket\|install\|findy"'
alias rocket='alias | grep rocket'
alias rocketssh='ssh sojojo@rocket.sojojoid.com'
alias rocketup='rocketup'
alias rocketdl='rocketdl'
alias rocketls='rocketls'
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
