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

alias ll='ls -AlhGF'

[ -f ~/.zprofile ] && source ~/.zprofile
