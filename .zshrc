source ~/.antigen/antigen.zsh

export http_proxy="http://secproxy.rockwellcollins.com:9090"
export https_proxy="https://secproxy.rockwellcollins.com:9090"

antigen use oh-my-zsh

antigen theme https://github.com/ratschance/lambda-mod-zsh-theme lambda-mod

antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search
#antigen bundle rimraf/k
antigen bundle teancom/k

BULLETTRAIN_TIME_SHOW=false

antigen apply

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/rubies/ruby-2.3.1/bin"

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
export PATH=$HOME/bin:$PATH

function smake(){
    make $@ |& tee -a "$(timestamp).vucs.log"
}

function timestamp(){
    date +"%F-%T"
}

function gen(){
    asciidoctor ${1} -D ~/www/notes
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


