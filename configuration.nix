# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nbfc.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.logind.lidSwitchDocked = "ignore";

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
      gedit
      gnome-console
      epiphany # web browser
      evince # document viewer
    ])
    ++ (with pkgs.gnome; [
      gnome-music
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      cheese # webcam tool
      gnome-terminal
      geary # email reader
      totem # video player
    ]);

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  #

  users.users.random-sir = {
    isNormalUser = true;
    description = "Random Sir";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      #group to use arduino
      "dialout"
      #group to use virtualbox
      "vboxusers"
    ];
    packages =
      (with pkgs; [
        #  thunderbird
      ])
      ++ (with pkgs.gnomeExtensions; [
        # Gnome extensions go here
        pop-shell
        caffeine
        vertical-workspaces
        dash-to-dock
        appindicator
        native-window-placement
        lock-keys
      ]);
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  #nh, the cool nix helper B-)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/random-sir/nixos-config";
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.vmware.host.enable = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wl-clipboard
    wezterm
    emacs
    alejandra
    nixfmt-rfc-style
    stow
    ripgrep
    fd
    fira-code
    discord
    cmake
    gnumake
    libgcc
    libtool
    gccgo14
    clang-tools
    python3
    vscode.fhs
    gnome.dconf-editor
    gnome.gnome-tweaks
    wget
    curl
    rustup
    musikcube
    zip
    unzip
    delta
    thefuck
    tealdeer
    fzf
    gdb
    gh
    bat
    bat-extras.batman
    nurl
    arduino-ide
    arduino-cli
    arduino-language-server
    arduino
    simulide_1_1_0
    pkgs-unstable.qbittorrent
    (aspellWithDicts (
      dicts: with dicts; [
        de
        en
        en-computers
        en-science
        pt_BR
      ]
    ))
    ghostwriter
    jetbrains.rust-rover
    libreoffice-qt6-still
    gimp
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
