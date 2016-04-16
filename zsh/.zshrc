export DISABLE_AUTO_TITLE="true"
export BROWSER="chromium"
export TERM="xterm-256color"
export GOPATH="$HOME/.go"

export PATH="$HOME/bin:$HOME/.go/bin:$PATH"

ZSH_THEME="kolo"
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git docker)

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
alias vpn='sudo openconnect -b -u josh5700 https://vpn1.ord1.rackspace.com'
alias shutdown='sudo systemctl poweroff'
alias pbcopy='xclip -selection clipboard -in'
alias clean_docker='sudo docker stop $(sudo docker ps -a -q) && sudo docker rm $(sudo docker ps -a -q)'
alias clean_images='sudo docker rmi $(sudo docker images -q)'
#------------------------------

alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS
unset GNOME_DESKTOP_SESSION_ID
unset DESKTOP_SESSION
