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

# SCRIPTS ALIASES
SCRIPTS_ROOT="/home/user/scripts"
alias lls="ll $SCRIPTS_ROOT"
alias generate-aliases="ls $SCRIPTS_ROOT | xargs -i echo \"alias {}=\$SCRIPTS_ROOT/{}; alias {}-e='vi \$SCRIPTS_ROOT/{}'\""

alias after-start=/home/user/scripts/after-start; alias after-start-e='vi /home/user/scripts/after-start'
alias charger=/home/user/scripts/charger; alias charger-e='vi /home/user/scripts/charger'
alias check-arr-ip=/home/user/scripts/check-arr-ip; alias check-arr-ip-e='vi /home/user/scripts/check-arr-ip'
alias check-play=/home/user/scripts/check-play; alias check-play-e='vi /home/user/scripts/check-play'
alias check-repos=/home/user/scripts/check-repos; alias check-repos-e='vi /home/user/scripts/check-repos'
alias clear-registry=/home/user/scripts/clear-registry; alias clear-registry-e='vi /home/user/scripts/clear-registry'
alias comment-generate=/home/user/scripts/comment-generate; alias comment-generate-e='vi /home/user/scripts/comment-generate'
alias docker-clean=/home/user/scripts/docker-clean; alias docker-clean-e='vi /home/user/scripts/docker-clean'
alias forward=/home/user/scripts/forward; alias forward-e='vi /home/user/scripts/forward'
alias forward-clear=/home/user/scripts/forward-clear; alias forward-clear-e='vi /home/user/scripts/forward-clear'
alias freeram=/home/user/scripts/freeram; alias freeram-e='vi /home/user/scripts/freeram'
alias graphical-start=/home/user/scripts/graphical-start; alias graphical-start-e='vi /home/user/scripts/graphical-start'
alias graphical-stop=/home/user/scripts/graphical-stop; alias graphical-stop-e='vi /home/user/scripts/graphical-stop'
alias guestap=/home/user/scripts/guestap; alias guestap-e='vi /home/user/scripts/guestap'
alias list-registry=/home/user/scripts/list-registry; alias list-registry-e='vi /home/user/scripts/list-registry'
alias list-registry-tags=/home/user/scripts/list-registry-tags; alias list-registry-tags-e='vi /home/user/scripts/list-registry-tags'
alias localip=/home/user/scripts/localip; alias localip-e='vi /home/user/scripts/localip'
alias lock-ssd=/home/user/scripts/lock-ssd; alias lock-ssd-e='vi /home/user/scripts/lock-ssd'
alias mp4conv=/home/user/scripts/mp4conv; alias mp4conv-e='vi /home/user/scripts/mp4conv'
alias remove-registry=/home/user/scripts/remove-registry; alias remove-registry-e='vi /home/user/scripts/remove-registry'
alias tm=/home/user/scripts/tm; alias tm-e='vi /home/user/scripts/tm'
alias tmp=/home/user/scripts/tmp; alias tmp-e='vi /home/user/scripts/tmp'
alias vps=/home/user/scripts/vps; alias vps-e='vi /home/user/scripts/vps'

# MISC ALIASES
alias cdrepos='cd /repositories'
alias cdtmp='cd /home/user/Downloads/tmp'
alias se='source env/bin/activate'
alias editBash="code /home/user/.bashrc"
alias lazy='cat ~/.bashrc | grep -i'
alias ip="ip -c"
# -G color output, -F slash after pathname, -q force printing ? for non graphic chars
alias ll="ls -GalFq"
alias k="kubectl"
alias kgp="kubectl get pods"
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}"'
alias myip='curl -s ipinfo.io'
#alias EM='export KUBECONFIG=".kube/config"'
#alias EK='export KUBECONFIG="/etc/rancher/k3s/k3s.yaml"'
alias haselka="keepassxc-cli open /mnt/google_drive/DB/DB-Mikele.kdbx"
usb=/mnt/mikele_usb
ssd=/mnt/mikele_ssd
monitor=/persistent_volumes/monitor
dirigera=/repositories/dirigera/app/storage
google=$ssd/GoogleDrive
export tmp=/home/user/Downloads/tmp
# this must be a script to make it accessible from ssh
#alias tm='[[ $(tmux ls | wc -l) -eq 0 ]] && tmux || tmux attach-session'
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
#alias ytdl='docker run \
#    --rm -i \
#    -e PGID=$(id -g) \
#    -e PUID=$(id -u) \
#    -v /persistent_volumes/ytdl/mp4:/workdir:z \
#    -v /persistent_volumes/ytdl/setup_route.sh:/setup_route.sh:z \
#    --network surfshark_bridge_net \
#    --entrypoint /setup_route.sh \
#    mikenye/youtube-dl'

alias mp4tomp3='function _mp4tomp3(){ ffmpeg -i "$1" -q:a 0 -map a "$2"; }; _mp4tomp3'
alias lsblk='lsblk --output NAME,FSTYPE,LABEL,SIZE,FSAVAIL,FSUSE%,MOUNTPOINTS'
alias rp=realpath

#############################################################
#                         	OTHER
#############################################################

export EDITOR=nvim
export VISUAL=nvim
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

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

# Load Angular CLI autocompletion.
source <(ng completion script)

