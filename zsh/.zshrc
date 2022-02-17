#!/usr/bin/env zsh

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

bindkey -e
setopt prompt_subst

# Load required modules
#
autoload -Uz vcs_info

# Set vcs_info parameters
#
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%u%c (%a)"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

# Fastest possible way to check if repo is dirty
#
git_dirty() {
    # Check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    # Check if it's dirty
    command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo "*"
}

# Display information about the current repository
#
repo_information() {
    echo "%F{blue}${vcs_info_msg_0_%%/.} %F{8}$vcs_info_msg_1_`git_dirty` $vcs_info_msg_2_%f"
}

# Displays the exec time of the last command if set threshold was exceeded
#
cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt 5 ] && echo ${elapsed}s
}

# Get the initial timestamp for cmd_exec_time
#
preexec() {
    cmd_timestamp=`date +%s`
}

# Output additional information about paths, repos and exec time
#
precmd() {
    vcs_info # Get version control info before we start outputting stuff
    print -P "\n$(repo_information) %F{yellow}$(cmd_exec_time)%f"
}

# Define prompts
#
PROMPT="%(?.%F{magenta}.%F{red})❯%f " # Display a red prompt char on failure
RPROMPT="%F{8}${SSH_TTY:+%n@%m}%f"    # Display username if connected via SSH


# ------------------------------------------------------------------------------
#
# List of vcs_info format strings:
#
# %b => current branch
# %a => current action (rebase/merge)
# %s => current version control system
# %r => name of the root directory of the repository
# %S => current path relative to the repository root directory
# %m => in case of Git, show information about stashes
# %u => show unstaged changes in the repository
# %c => show staged changes in the repository
#
# List of prompt format strings:
#
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
#
# ------------------------------------------------------------------------------

if [ $commands[fasd] ]; then # check if fasd is installed
  fasd_cache="$HOME/.fasd-init-cache"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache

  alias v="f -e \"$EDITOR\""
  alias o='a -e open_command'
fi

#Play safe!
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias dmesg='dmesg --ctime'
alias df='df --exclude-type=tmpfs'
alias ls='ls -GF'
alias ll='ls -Glh'
# alias pbcopy='xclip -selection clipboard -in'
alias clean_docker='sudo docker stop $(sudo docker ps -a -q) && sudo docker rm $(sudo docker ps -a -q)'
alias clean_images='sudo docker rmi $(sudo docker images -q)'
# alias top='htop'
alias startx="startx -- -keeptty"
alias vim="nvim"
alias gd="git diff"
alias gdc="git diff --cached"
alias gst="git status"
alias glo="git log --oneline"
alias gco="git checkout"
alias gcan="git commit --amend --no-edit"
alias ..="cd .."
alias dc="docker-compose"

# User configuration
export PATH="$HOME/.local/bin:$HOME/.cabal/bin:$HOME/.cargo/bin:$HOME/purescript:$GOPATH/bin:$HOME/.nix-profile/bin:$PATH"
export GOPATH="$HOME/go"
export LANG=en_US.UTF-8
export EDITOR=nvim
export TERM=xterm-256color
export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/m117129/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/m117129/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/m117129/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/m117129/google-cloud-sdk/completion.zsh.inc'; fi
if [ -e /Users/m117129/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/m117129/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
