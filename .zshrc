source ~/.antigen/antigen.zsh

antigen use oh-my-zsh

antigen theme https://github.com/ratschance/lambda-mod-zsh-theme lambda-mod

antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search
antigen bundle teancom/k

antigen apply

bindkey -r '^[h'
bindkey -r '^[j'
bindkey -r '^[k'
bindkey -r '^[l'
bindkey -r '^[u'
bindkey -r '^[i'
bindkey -r '^[o'
bindkey -r '^[p'

alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -AlhGF'
alias kk='k -Ah'
alias tmux='tmux -2'
alias vim='VIMRUNTIME=/usr/share/vim/vim74 nvim'
alias dockdel='docker rm $(docker ps -a -q -f status=exited)'

function smake(){
    make $@ |& tee -a "$(timestamp).log"
}

function timestamp(){
    date +"%F-%T"
}

function gen(){
    asciidoctor ${1} -D ~/www/notes
}

[ -f ~/.zprofile ] && source ~/.zprofile

