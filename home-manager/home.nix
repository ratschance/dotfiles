{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cr";
  home.homeDirectory = "/Users/cr";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    aerospace
    btop
    bat
    eza
    fd
    fzf
    git
    gh
    ghostty-bin
    go
    gofumpt
    httpie
    kubectl
    kubectl-klock
    kubectx
    kubernetes-helm
    kubecolor
    kind
    k9s
    lazygit
    lsd
    neovim
    nodejs
    opentofu
    python3
    ripgrep
    talosctl
    stern
    tealdeer
    tmux
    tree-sitter
    yq-go
    virtualenv
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    sessionVariables = {
      STARSHIP_CONFIG = "${config.home.homeDirectory}/.config/starship.toml";
      EDITOR = "nvim";
      PATH = "$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH";
    };

    shellAliases = {
      ls = "lsd";
      l = "lsd -l";
      la = "lsd -A";
      ll = "lsd -AlhGF";
      lt = "lsd --tree";
      lg = "lazygit";
      k = "kubecolor";
      vim = "nvim";
      tm = "tmux new -s m || tmux a -t m";
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      saveNoDups = true;
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };

    plugins = [
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "334c14d1b49ec8393292b16b2a972f20570361ac";
          sha256 = "nrWI/EWHKPIKwFRZnm6nRK7c+9U3NHllW8B3zzAtfNs=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "c4d95591843d49838b7ad30081e7aba3135a6703";
          sha256 = "4XXqgMaB+l8ZKRJEuxuC1yqQRFhP/0ySELsSJTvjf8k=";
        };
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "14c8d2e0ffaee98f2df9850b19944f32546fdea5";
          sha256 = "KHujL1/TM5R3m4uQh2nGVC98D6MOyCgQpyFf+8gjKR0=";
        };
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "91cafe4a09b6670cb8e761aa413e5f7b9e00816f";
          sha256 = "5ZYcxl5sjfn1XfQ7D28Si4OXwCHHapAJSboJfNgl/5A=";
        };
      }
    ];

    initContent = ''
      # Sensible setopts
      setopt AUTO_CD
      setopt EXTENDED_GLOB
      setopt INTERACTIVE_COMMENTS

      # Colorization
      export CLICOLOR=1
      export LSCOLORS="exfxcxdxbxegedabagacad"
      zstyle ':completion:*' list-colors ""

      # Basic completion styling
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select

      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      source <(kubectl completion zsh)
      compdef _kubectl k kubecolor
      source <(gh completion -s zsh)
      source <(docker completion zsh)

      # History substring search bindings
      zmodload zsh/terminfo
      [[ -n "$terminfo[kcuu1]" ]] && bindkey "$terminfo[kcuu1]" history-substring-search-up
      [[ -n "$terminfo[kcud1]" ]] && bindkey "$terminfo[kcud1]" history-substring-search-down
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      bindkey -r '^[h'
      bindkey -r '^[j'
      bindkey -r '^[k'
      bindkey -r '^[l'
      bindkey -r '^[u'
      bindkey -r '^[i'
      bindkey -r '^[o'
      bindkey -r '^[p'

      apt-history() {
          zcat -qf /var/log/apt/history.log* | grep -Po '^Commandline: apt install (?!.*--reinstall)\K.*'
      }

      [ -f ~/.zprofile ] && source ~/.zprofile
      [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

      eval "$(starship init zsh)"
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
