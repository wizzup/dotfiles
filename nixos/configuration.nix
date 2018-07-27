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
      # ipAddress = "192.168.1.4";
      # prefixLength = 24;
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
    # binaryCaches = [ "https://cache.nixos.org" "https://nixcache.reflex-frp.org" ];
    # binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

    extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
    '';
  };

  nixpkgs = {
    system = "x86_64-linux";

    config.allowUnfree = true;
    config.virtualbox.enableExtensionPack = true;
  };

  programs = {
    bash.enableCompletion = true;
    command-not-found.enable = true;
  };

  ##  fonts
  fonts = {
    enableDefaultFonts = true;

    fonts = [
      google-fonts
      noto-fonts
      noto-fonts-cjk
      terminus_font
      terminus_font_ttf
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
    parted
  ];

  # services = {
    # ipfs.enable = true;
    # openssh.enable = true;
    # openssh.permitRootLogin = "yes";
  # };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.printing = {
    enable = true;
    # drivers = [ samsung-unified-linux-driver ];
  };

  services.dbus.packages = [ gnome3.dconf ];

  services.udisks2.enable = true;

  services.gnome3 = {
    sushi.enable = true;
    gvfs.enable = true;
    gnome-disks.enable = true;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=50M
    MaxRetentionSec=10day
    '';

  # sound via ALSA
  # sound.enable = true;

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

        # xrandrHeads = [
        #   { output = "DVI-I-1";}
        #   { output = "DVI-I-2";}
        # ];

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

        # desktopManager.lxqt.enable = true;
    };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  virtualisation.virtualbox.host.enable = true;

  users.extraUsers = {
    wizzup = {
      isNormalUser = true;
      home = "/home/wizzup";
      description = "wizzup";
      extraGroups = ["audio" "wheel" "docker" "vboxusers"];
      packages = [
        ## terminal apps
        btrfs-progs
        file
        gcc
        git
        gnumake
        htop
        neovim
        p7zip
        psmisc
        tmux
        tree
        unrar
        unzip
        wget
        xsel
        # jre

        ## graphical apps
        # firefox-devedition-bin
        # gnucash26
        chromium
        ffmpegthumbnailer
        firefox
        gnucash
        keepassx2
        # libreoffice-fresh
        libreoffice-still
        neovim-qt
        scrot
        transmission_gtk
        vlc

        gnome3.dconf-editor
        gnome3.eog
        gnome3.evince
        gnome3.file-roller
        gnome3.gconf
        gnome3.gnome-disk-utility
        gnome3.gnome_control_center
        gnome3.nautilus
        shared_mime_info
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

  # system.stateVersion = "18.03";
  system.nixos.stateVersion = "18.03";

}
