{ config, pkgs, ... }:

{
  imports = [
    ../modules/common.nix
  ];

  home.username = "cr";
  home.homeDirectory = "/Users/cr";

  home.packages = with pkgs; [
    aerospace
    ghostty-bin
  ];

  programs.zsh.shellAliases = {
    hms = "home-manager switch --flake '~/projects/dotfiles/home-manager#cr@mac'";
  };
}
