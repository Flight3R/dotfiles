# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

#############################################################
#                         PROMPT
#############################################################
# Fzf history bind to ctrl+r
source <(fzf --zsh)
export FZF_CTRL_R_OPTS="
  --height=60%
  --layout=reverse
  --border
  --info=inline
"
bindkey "^R" fzf-history-widget

# Zsh autosuggestions and command comppletion 
zstyle ":completion:*" menu select
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Edit command with ctrl+x+e in editor (nvim)
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Color definitions
RED="%F{red}"
YELLOW="%F{yellow}"
BLUE="%F{blue}"
GREEN="%F{green}"
MAGENTA="%F{magenta}"
RESET="%f"
# Default prompt (override in .zshrc.local file)
PROMPT="%B${RED}[${RESET}${BLUE}%n@%m${RESET} (%*) %~${RED}]${RESET}${vcs_info_msg_0_} > %b"

# Git branch in prompt
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ":vcs_info:git:*" formats "(%b)"

# Auto resume job in background after ctrl+z
autoload -Uz add-zsh-hook
_auto_bg_stopped_job() {
  emulate -L zsh
  if jobs -s >/dev/null 2>&1; then
    bg %+ >/dev/null 2>&1
  fi
}
add-zsh-hook precmd _auto_bg_stopped_job
#############################################################
#                         ALIASES
#############################################################
# GIT ALIASES
alias gal="alias | grep -E 'git [a-z]+.*[^'\'']'"
alias gre="git restore"
alias gsw="git switch"
alias gb="git branch"
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gl="git log -2 --name-only"
alias glo="git log -10 --oneline"
alias gcm="git commit"
alias gr="git rebase"
alias gfo="git fetch origin"
alias gp="git push"
alias gpl="git pull"
alias gbc="git branch --show-current"

# DOTFILES ALIASES
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias dfal="alias | grep -E 'dotfiles [a-z]+.*[^'\'']'"
alias dfre="dotfiles restore"
alias dfsw="dotfiles switch"
alias dfb="dotfiles branch"
alias dfa="dotfiles add"
alias dfs="dotfiles status"
alias dfd="dotfiles diff"
alias dfl="dotfiles log -2 --name-only"
alias dflo="dotfiles log -10 --oneline"
alias dfcm="dotfiles commit"
alias dfr="dotfiles rebase"
alias dffo="dotfiles fetch origin"
alias dfp="dotfiles push"
alias dfpl="dotfiles pull"
alias dfbc="dotfiles branch --show-current"

# MISC ALIASES
alias cdrepos="cd ~/repos"
alias se="source venv/bin/activate"
alias ip="ip -c"
# -G color output, -F slash after pathname, -q force printing ? for non graphic chars
alias ll="ls -GalFq"
alias de="tmux detach"
alias vi=nvim
alias rp=realpath
alias bn=basename
alias dn=dirname
alias lls="ll $HOME/.local/bin"
alias myip="curl -s ipinfo.io"
alias l="less"
alias h="head"
alias t="tail"
alias c="cat"

# DOCKER ALIASES
alias d="docker"
alias dc="docker compose"
alias dps="docker ps --format 'table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}'"
alias dpsa="dps -a"

#############################################################
#                         LOCAL
#############################################################
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
