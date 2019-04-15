# NixOS configuration file for earth by wizzup
# /etc/nixos/configuration.nix

{ config, pkgs, ... }:
with pkgs;

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking = {
    useDHCP = false;
    hostName = "earth";
    enableIPv6 = false;
    defaultGateway = "192.168.1.1";
    nameservers = ["8.8.8.8" "8.8.4.4"];
    interfaces.enp0s7 = {
      ipv4.addresses = [{ address = "192.168.1.4"; prefixLength = 24; }];
    };
  };

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Asia/Bangkok";

  nix = {
    maxJobs = 2;

    useSandbox = true;

    # default level is 0, valid values are 0 to 19
    daemonNiceLevel = 10;

    # default level is 0, valid values are 0 to 7
    daemonIONiceLevel = 4;

    binaryCaches = [
      "https://cache.nixos.org"
      "https://hie-nix.cachix.org"
      "https://wizzup.cachix.org"
      # "https://nixcache.reflex-frp.org"
    ];

    binaryCachePublicKeys = [
      "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
      "wizzup.cachix.org-1:FDHBjAYzhSSGmX3ZGIhgl3+uwNFblIOzjPTb0edaVOw="
      # "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];

    # extraOptions = ''
    #   gc-keep-outputs = true
    #   gc-keep-derivations = true
    # '';

    gc.automatic = true;
    gc.options = "--delete-older-than 15d";
  };

  nixpkgs = {
    system = "x86_64-linux";

    config.allowUnfree = true;
    # config.virtualbox.enableExtensionPack = true;

    overlays = [
      (import /data/works/dotfiles/nixpkgs/overlays/neovim.nix)
    ];
  };

  programs = {
    bash.enableCompletion = true;
    command-not-found.enable = true;
    sway.enable = true;
  };

  ##  fonts
  fonts = {
    enableDefaultFonts = true;

    fonts = [
      # nerdfonts
      fira-code
      source-code-pro
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-cjk
    ];
  };

  environment.systemPackages = [

    ## common utils
    alsaUtils
    dmenu
    dunst
    dzen2
    feh
    gmrun
    pavucontrol
    xdg_utils

    ## terminals
    alacritty
    kitty
    rxvt_unicode-with-plugins
    termite
    xterm

    # sway utils
    grim
    i3blocks
    i3status
    slurp

    # icons
    arc-icon-theme
    gnome2.gnome_icon_theme
    gnome3.adwaita-icon-theme
    hicolor_icon_theme

    # system utils
    btrfs-progs
    file
    inotify-tools
    lm_sensors
    parted
    psmisc
    tree
    usbutils
  ];

  services = {
    dbus.packages = [ gnome3.dconf ];

    gnome3 = {
      sushi.enable = true;
      gvfs.enable = true;
      gnome-disks.enable = true;
    };

    journald.extraConfig = ''
      SystemMaxUse=50M
      MaxRetentionSec=10day
      '';
  };

  zramSwap.enable = true;

  hardware = {
    enableAllFirmware = true;

    # sound via PulseAudio
    pulseaudio = {
      enable = true;
      support32Bit = true;

      # pulseaudioLight does *not* have module-x11-publish.so
      # https://github.com/NixOS/nixpkgs/issues/11970
      package = pulseaudioFull;
    };

    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  users.extraUsers = {
    wizzup = {
      isNormalUser = true;
      home = "/home/wizzup";
      description = "wizzup";
      extraGroups = ["audio" "wheel" "docker" "vboxusers" "sway"];
      packages = [
        ## terminal apps
        git
        gnumake
        htop
        neovim
        p7zip
        ranger
        tmux
        unrar
        unzip
        wget
        xsel
        haskellPackages.steeloverseer
        nodePackages.livedown
        entr

        ## TODO: move to custom nvim override
        ## need for nvim's coc
        yarn
        nodejs

        ## need for ranger preview
        ffmpegthumbnailer
        poppler_utils
        w3m

        ## graphical apps
        neovim-qt
        chromium
        firefox
        firefox-wayland
        gnucash
        keepassx2
        libreoffice
        # libreoffice-fresh
        scrot
        transmission_gtk
        vlc

        # shared_mime_info
        gnome3.dconf-editor
        gnome3.eog
        gnome3.evince
        gnome3.file-roller
        gnome3.gnome-disk-utility
        gnome3.nautilus
        gnome3.totem
        shotwell

        ];
    };

    game = {
      isNormalUser = true;
      home = "/home/game";
      description = "game";
      packages = [
        # steam
      ];
    };

  };

  system.stateVersion = "18.03";
}
