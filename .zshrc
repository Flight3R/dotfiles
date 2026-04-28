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
setopt HIST_IGNORE_ALL_DUPS
fzf-history-widget() {
    BUFFER=$(fc -l -n 1 | fzf --tac --query="$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget

zstyle ':completion:*' menu select

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Color definitions
RED='%F{red}'
YELLOW='%F{yellow}'
BLUE='%F{blue}'
GREEN='%F{green}'
MAGENTA='%F{magenta}'
RESET='%f'
# Override default PROMPT in LOCAL section
PROMPT='%B${RED}[${RESET}${BLUE}%n@%m${RESET} (%*) %~${RED}]${RESET}${vcs_info_msg_0_} > %b'

autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '(%b)'

#############################################################
#                         ALIASES
#############################################################
# GIT ALIASES
alias gitaliases="alias | grep -E 'git [a-z]+.*[^'\'']'"
alias gfo="git fetch origin"
alias gre="git restore"
alias grt="git reset"
alias gsw="git switch"
alias gb="git branch"
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gl="git log -2 --name-only"
alias gcm="git commit"
alias gcma="git commit --amend"
alias gcman="git commit --amend --no-edit"
alias gfod="git fetch origin develop"
alias grod="git rebase origin/develop"
alias gpo="git push origin"
alias gcl="git clean -fd"
alias gbc="git branch --show-current"
alias gr="git reflog -10"
alias glr="git log --oneline --reflog -10"

# DOTFILES ALIASES
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dfa="dotfiles add"
alias dfc="dotfiles commit"
alias dfs="dotfiles status"
alias dfd="dotfiles diff"

# MISC ALIASES
alias cdrepos='cd /repositories'
alias se='source .env/bin/activate'
alias ip="ip -c"
# -G color output, -F slash after pathname, -q force printing ? for non graphic chars
alias ll="ls -GalFq"

alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}"'

alias myip='curl -s ipinfo.io'

usb=/mnt/mikele_usb
ssd=/mnt/mikele_ssd
alias cdtmp='cd $HOME/Downloads/tmp'
export tmp=$HOME/Downloads/tmp

alias de="tmux detach"
alias vi=nvim
alias rp=realpath
alias bn=basename
alias dn=dirname
alias lls="ll $HOME/.local/bin"

#sudo chown -R user:user /persistent_volumes/ytd
alias ytdl='docker run \
                  --rm -i \
                  -e PGID=$(id -g) \
                  -e PUID=$(id -u) \
                  -v /persistent_volumes/ytdl/mp4:/workdir:z \
                  mikenye/youtube-dl'

alias mp4tomp3='function _mp4tomp3(){ ffmpeg -i "$1" -q:a 0 -map a "$2"; }; _mp4tomp3'
alias lsblk='lsblk --output NAME,FSTYPE,LABEL,SIZE,FSAVAIL,FSUSE%,MOUNTPOINTS'

#############################################################
#                         	OTHER
#############################################################
export EDITOR=nvim
export VISUAL=nvim

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

#############################################################
#                         LOCAL
#############################################################
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
