{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
  };

  home.username = "random-sir";
  home.homeDirectory = "/home/random-sir";

  programs.git = {
    enable = true;
    userName = "random-sir";
    userEmail = "antoni.torres@outlook.com";
    extraConfig = {
      core = {
        editor = "nvim";
      };
      init = {
        defaultBranch = "main";
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
    };

    delta.enable = true;
    delta.options = {
      navigate = true;
      light = false;
    };
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      zoxide init fish | source
    '';

    shellAbbrs = {
      #git commands
      gd = "git diff";

      #nix commands
      ns = "nh os switch";
      nsu = "nh os switch -u";
      nt = "nh os test";
      ntu = "nh os test -u";
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
