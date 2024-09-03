{ config, pkgs, ... }:

{
  home.username = "random-sir";
  home.homeDirectory = "/home/random-sir";

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      zoxide init fish | source
    '';

    shellAbbrs = {
      #git commands
      gd = "git diff";
    };

    plugins = [
      {
        name = "puffer-fish";
        src = pkgs.fishPlugins.puffer.src;
      }

      {
        name = "gitnow";
        src = pkgs.fetchFromGitHub {
          owner = "joseluisq";
          repo = "gitnow";
          rev = "2.12.0"; # Version to fetch
          sha256 = "sha256-PuorwmaZAeG6aNWX4sUTBIE+NMdn1iWeea3rJ2RhqRQ="; # Remember to invalidate when updating
        };
      }

      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }

      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
    ];
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
