export ZSH=/usr/share/oh-my-zsh
export DISABLE_AUTO_TITLE="true"
export PATH="$HOME/bin:$HOME/.go/bin:$PATH"
export BROWSER="chromium"
export TERM="xterm-256color"
export GOPATH="$HOME/.go"


ZSH_THEME="kolo"
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git fasd docker)
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi
source $ZSH/oh-my-zsh.sh

#------------------------------
# Alias stuff
#------------------------------
# Play safe!
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias dmesg='dmesg --ctime'
alias df='df --exclude-type=tmpfs'
alias e='emacsclient -t'
alias ec='emacsclient -c'
alias ls='ls --color -F'
alias ll='ls --color -lh'
alias vpn='sudo openconnect -b -u josh5700 https://vpn1.ord1.rackspace.com --script /etc/vpnc/vpnc-script'
alias wifi='sudo wpa_supplicant -B -iwlan0 -c/home/josh/wpa_home.conf -Dwext && sudo dhclient wlan0'
alias rfast='sudo wpa_supplicant -B -iwlan0 -c/home/josh/wpa_work.conf -Dwext && sudo dhclient wlan0'
alias shutdown='sudo systemctl poweroff'
alias pbcopy='xclip -selection clipboard -in'
alias resty='sudo docker run -t -i -p 8080:8080 -v=`pwd`:/resty -w=/resty openresty'
alias clean_docker='sudo docker stop $(sudo docker ps -a -q) && sudo docker rm $(sudo docker ps -a -q)'
alias clean_images='sudo docker rmi $(sudo docker images -q)'
alias npmx='PATH=$(npm bin):$PATH'
alias bower='noglob bower'
#------------------------------

alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS
unset GNOME_DESKTOP_SESSION_ID
unset DESKTOP_SESSION
