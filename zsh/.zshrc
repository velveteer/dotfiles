export ZSH=/home/josh/.oh-my-zsh
ZSH_THEME="kolo"
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git docker fasd)

#Play safe!
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias dmesg='dmesg --ctime'
alias df='df --exclude-type=tmpfs'
alias ls='ls --color -F'
alias ll='ls --color -lh'
alias pbcopy='xclip -selection clipboard -in'
alias clean_docker='sudo docker stop $(sudo docker ps -a -q) && sudo docker rm $(sudo docker ps -a -q)'
alias clean_images='sudo docker rmi $(sudo docker images -q)'
alias top='htop'
alias startx="startx -- -keeptty"
alias open="xdg-open"
alias vim="nvim"

# User configuration
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/purescript:$GOPATH/bin:$HOME/.nix-profile/bin:$PATH"
export GOPATH="$HOME/go"
source $ZSH/oh-my-zsh.sh
export SSH_ASKPASS=""
export LANG=en_US.UTF-8
export TERM=xterm
export GDK_DPI_SCALE=1
export GTK_SCALE=2
export QT_SCREEN_SCALE_FACTORS=1
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# added by travis gem
[ -f /home/josh/.travis/travis.sh ] && source /home/josh/.travis/travis.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
