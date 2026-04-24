# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/user/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PATH="/home/user/.local/bin:$PATH"
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

autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '(%b)'
PROMPT='%B${RED}[${RESET}${BLUE}%n@%m${RESET} ${YELLOW}(%*)${RESET} ${BLUE}%~${RESET}${RED}]${RESET}${vcs_info_msg_0_} > %b'

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

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# MISC ALIASES
alias cdrepos='cd /repositories'
alias cdtmp='cd /home/user/Downloads/tmp'
alias se='source env/bin/activate'
alias editBash="code /home/user/.bashrc"
alias lazy='cat ~/.bashrc | grep -i'
alias ip="ip -c"
# -G color output, -F slash after pathname, -q force printing ? for non graphic chars
alias ll="ls -GalFq"
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}"'
alias myip='curl -s ipinfo.io'
usb=/mnt/mikele_usb
ssd=/mnt/mikele_ssd
monitor=/persistent_volumes/monitor
dirigera=/repositories/dirigera/app/storage
google=$ssd/GoogleDrive
export tmp=/home/user/Downloads/tmp
alias de="tmux detach"
alias tmls="tmux list-sessions"
alias vi=nvim
alias rp=realpath

#sudo chown -R user:user /persistent_volumes/ytd
alias ytdl='docker run \
                  --rm -i \
                  -e PGID=$(id -g) \
                  -e PUID=$(id -u) \
                  -v /persistent_volumes/ytdl/mp4:/workdir:z \
                  mikenye/youtube-dl'

alias mp4tomp3='function _mp4tomp3(){ ffmpeg -i "$1" -q:a 0 -map a "$2"; }; _mp4tomp3'
alias lsblk='lsblk --output NAME,FSTYPE,LABEL,SIZE,FSAVAIL,FSUSE%,MOUNTPOINTS'
alias rp=realpath

#############################################################
#                         	OTHER
#############################################################

export EDITOR=nvim
export VISUAL=nvim

echo "\
192.168.0.1/24  <- def gw
192.168.0.2/24  <- server
192.168.0.3/24  <- ap
192.168.0.4/24  <- guest ap
192.168.0.17/28 <- firewall
192.168.0.18/28 <- macvlan
192.168.0.19/28 <- pihole
192.168.0.20/28 <- surfshark
192.168.0.21/28 <- dirigera_c
192.168.0.32/28 <- macbook man
192.168.0.98/24 <- monitor
192.168.0.99/24 <- dirigera
- - - - - - - - - - - - - - -"

export PATH="$HOME/.npm-global/bin:$PATH"

