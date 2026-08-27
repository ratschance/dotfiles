{ config, pkgs, lib, ... }:

{
  # Username and homeDirectory are now defined in hosts/<host>.nix

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.activation = {
    rsync-home-manager-applications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
      apps_source="$genProfilePath/home-path/Applications"
      mac_apps="$HOME/Applications/Nix Apps"
      $DRY_RUN_CMD mkdir -p "$mac_apps"
      $DRY_RUN_CMD ${pkgs.rsync}/bin/rsync ''${rsyncArgs} "$apps_source/" "$mac_apps/"
    '';
  };

  home.packages = with pkgs; [
    btop
    bat
    fd
    fzf
    git
    gh
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
    (pkgs.bun.overrideAttrs (oldAttrs: rec {
      version = "1.3.14";
      src = pkgs.fetchurl {
        url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-${if pkgs.stdenv.isDarwin then "darwin" else "linux"}-${if pkgs.stdenv.isAarch64 then "aarch64" else "x64"}.zip";
        sha256 = {
          "aarch64-darwin" = "sha256-2LliIYKK1vl6x6wKt+lYcjQa92MAHogD6CZ2UsJlJiA=";
          "x86_64-linux" = "sha256-lR7iruhV8IWVruxiJSJqKY0/6oOj3NZGXAnLzN9+hI8=";
        }.${pkgs.stdenv.hostPlatform.system} or pkgs.lib.fakeSha256;
      };
    }))
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

  home.file = {
    ".vimrc".source = lib.mkDefault ../../.vimrc;
    ".tmux.conf".source = lib.mkDefault ../../.tmux.conf;
    ".config/starship.toml".source = lib.mkDefault ../../starship.toml;
    ".config/alacritty/alacritty.toml".source = lib.mkDefault ../../alacritty.toml;
    ".config/ghostty".source = lib.mkDefault ../../ghostty;
    ".config/aerospace/aerospace.toml".source = lib.mkDefault ../../aerospace.toml;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultOptions = [ "--color=dark" ];
    fileWidget.command = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude node_modules --exclude target --exclude .direnv";
    fileWidget.options = [ "--preview 'bat -n --color=always {}'" "--bind 'ctrl-/:change-preview-window(down|hidden|)'" ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    sessionVariables = {
      STARSHIP_CONFIG = "${config.home.homeDirectory}/.config/starship.toml";
      EDITOR = "nvim";
      PATH = "$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH:$HOME/.bun/bin/";
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
    ];

    initContent = ''
      # Sensible setopts
      setopt AUTO_CD
      setopt AUTO_PUSHD
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
    '';
  };

  programs.zsh.profileExtra = ''
    # Load private config that we don't want to check in
    if [ -f ~/.zprofile.local ]; then
      source ~/.zprofile.local
    fi
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
