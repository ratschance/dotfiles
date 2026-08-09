export STARSHIP_CONFIG="$HOME/.config/starship.toml"
source ~/.antigen/antigen.zsh
antigen use oh-my-zsh
#antigen theme https://github.com/ratschance/hodgepodge-theme hodgepodge
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search
antigen apply

autoload -Uz compinit
compinit -i

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

[ -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ] && source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

source <(kubectl completion zsh)
alias k='kubecolor'
compdef _kubectl k kubecolor

source <(gh completion -s zsh)
source <(docker completion zsh)

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

# Opinionated must haves
alias ll='ls -AlhGF'
export PATH="$PATH:$HOME/bin"


apt-history() {
    zcat -qf /var/log/apt/history.log* | grep -Po '^Commandline: apt install (?!.*--reinstall)\K.*'
}

[ -f ~/.zprofile ] && source ~/.zprofile

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Added by Antigravity CLI installer
export PATH="/Users/cr/.local/bin:$PATH"
