# NixOS configuration file for earth by wizzup
# /etc/nixos/configuration.nix

{ config, pkgs, ... }:
with pkgs;

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  zramSwap = {
    enable = true;
    numDevices = 2;
  };

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
    maxJobs = lib.mkDefault 2;
    # useSandbox = true;

    binaryCaches = [
      "https://cache.nixos.org"
      "https://hie-nix.cachix.org"
      # "https://nixcache.reflex-frp.org"
    ];

    binaryCachePublicKeys = [
      "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
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
      # (import ./overlays/neovim.nix)
    ];
  };

  programs = {
    bash.enableCompletion = true;
    command-not-found.enable = true;
  };

  ##  fonts
  fonts = {
    enableDefaultFonts = true;

    fonts = [
      dejavu_fonts
      fira-code
      google-fonts
      hasklig
      noto-fonts
      noto-fonts-cjk
      source-code-pro
      terminus_font
      terminus_font_ttf
      twemoji-color-font
    ];
  };

  environment.systemPackages = [

    ## xmonad utils
    dmenu
    dzen2
    gmrun
    lm_sensors
    termite
    rxvt_unicode-with-plugins
    trayer
    pasystray
    pavucontrol
    dunst
    feh
    # taffybar
    alsaUtils

    ## haskell packages
    haskellPackages.xmobar

    # openbox utils
    obconf
    tint2

    # icons
    arc-icon-theme
    hicolor_icon_theme
    gnome2.gnome_icon_theme
    gnome3.adwaita-icon-theme

    # system utils
    btrfs-progs
    file
    inotify-tools
    parted
    psmisc
    tree
  ];

  services = {
    # ipfs.enable = true;
    # openssh.enable = true;
    # openssh.permitRootLogin = "yes";

    avahi = {
      enable = true;
      nssmdns = true;
    };

    printing = {
      enable = true;
      # drivers = [ samsung-unified-linux-driver ];
    };

    dbus.packages = [ gnome3.dconf ];

    udisks2.enable = true;

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

  # sound via PulseAudio
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;

    # pulseaudioLight does *not* have module-x11-publish.so
    # https://github.com/NixOS/nixpkgs/issues/11970
    package = pkgs.pulseaudioFull;
  };

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver = {
        enable = true;
        layout = "us, th";
        xkbOptions = "grp:lalt_lshift_toggle, caps:swapescape";

        videoDrivers = [ "nvidiaLegacy340" ];

        windowManager.openbox.enable = true;

        windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };

        windowManager.default = "xmonad";

        displayManager.sddm = {
          enable = true;
          autoNumlock = true;
        };
    };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  # virtualisation.virtualbox.host.enable = true;

  users.extraUsers = {
    wizzup = {
      isNormalUser = true;
      home = "/home/wizzup";
      description = "wizzup";
      extraGroups = ["audio" "wheel" "docker" "vboxusers"];
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

        ## graphical apps
        # neovim-qt
        chromium
        ffmpegthumbnailer
        firefox
        gnucash
        keepassx2
        # libreoffice
        libreoffice-fresh
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
