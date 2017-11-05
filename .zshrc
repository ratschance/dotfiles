source ~/.antigen/antigen.zsh

antigen use oh-my-zsh

antigen theme https://github.com/ratschance/lambda-mod-zsh-theme lambda-mod

antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search
antigen bundle rimraf/k

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

alias ll='ls -AlhGF'
alias dockdel='docker rm $(docker ps -a -q -f status=exited)'
export PATH=$HOME/bin:$PATH
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/projects/go"
export PATH="$PATH:$GOPATH/bin"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
