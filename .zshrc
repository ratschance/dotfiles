source ~/.antigen/antigen.zsh
antigen use oh-my-zsh
antigen theme https://github.com/ratschance/hodgepodge-theme hodgepodge
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search
antigen apply

bindkey -r '^[h'
bindkey -r '^[j'
bindkey -r '^[k'
bindkey -r '^[l'
bindkey -r '^[u'
bindkey -r '^[i'
bindkey -r '^[o'
bindkey -r '^[p'

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

alias ll='ls -AlhGF'

apt-history() {
    zcat -qf /var/log/apt/history.log* | grep -Po '^Commandline: apt install (?!.*--reinstall)\K.*'
}

[ -f ~/.zprofile ] && source ~/.zprofile
