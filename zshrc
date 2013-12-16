#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias vpn='sudo openconnect -b -u josh5700 https://vpn1.dfw1.rackspace.com --script /etc/vpnc/vpnc-script'
alias shutdown='sudo systemctl poweroff'

#Powerline shell
function powerline_precmd() {
  export PS1="$(~/powerline-shell.py $? --shell zsh)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
if [ "$s" = "powerline_precmd" ]; then
return
fi
done
precmd_functions+=(powerline_precmd)
}

install_powerline_precmd


