{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/common.nix
  ];

  home.username = "ratschanc";
  home.homeDirectory = "/home/ratschanc";

  # Disable macOS specific Spotlight activation script on Linux
  home.activation.rsync-home-manager-applications = lib.mkForce "";

  programs.zsh.shellAliases = {
    hms = "home-manager switch --flake '~/projects/dotfiles/home-manager#cr@desktop'";
  };
}
