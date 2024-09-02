{ config, pkgs, ... }:

{
  home.username = "random-sir";
  home.homeDirectory = "/home/random-sir";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
