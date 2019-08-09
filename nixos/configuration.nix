# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;

let
  # all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
  # hie = all-hies.selection { selector = p: { inherit (p) ghc865; }; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
        enable = true;
        version = 2;
        device = "/dev/disk/by-id/wwn-0x50014ee1002d4ea2";
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
    consoleFont = "Lat2-Terminus16";
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
      "https://wizzup.cachix.org"
      "https://all-hies.cachix.org"
    ];

    binaryCachePublicKeys = [
      "wizzup.cachix.org-1:FDHBjAYzhSSGmX3ZGIhgl3+uwNFblIOzjPTb0edaVOw="
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
    ];

    gc.automatic = true;
    gc.options = "--delete-older-than 15d";
  };

  nixpkgs = {
    system = "x86_64-linux";

    config.allowUnfree = true;

    # config.virtualbox.enableExtensionPack = true;

    overlays = [
      (import /data/works/dotfiles/nixpkgs/overlays/neovim.nix)
      (import /data/works/dotfiles/nixpkgs/overlays/st.nix)
      (import /data/works/dotfiles/nixpkgs/overlays/ranger.nix)
    ];
  };

  ##  fonts
  fonts = {
    enableDefaultFonts = true;

    fonts = [
      source-code-pro
      fira-code

      tlwg

      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-cjk
    ];
  };

  environment.systemPackages = with pkgs; [
    # libreoffice-fresh
    alacritty
    alsaUtils
    arc-icon-theme
    btrfs-progs
    cabal2nix
    cachix
    chromium
    dmenu
    dunst
    dzen2
    entr
    feh
    ffmpegthumbnailer
    file
    firefox
    gitAndTools.gitFull
    ghostscriptX
    gmrun
    gnome2.gnome_icon_theme
    gnome3.adwaita-icon-theme
    gnome3.dconf-editor
    gnome3.eog
    gnome3.evince
    gnome3.file-roller
    gnome3.gnome-disk-utility
    gnome3.nautilus
    gnome3.totem
    gnucash
    gnumake
    haskellPackages.steeloverseer
    hicolor_icon_theme
    # hie
    htop
    inotify-tools
    kakoune
    keepassx2
    kitty
    libreoffice
    lm_sensors
    neovim
    neovim-qt
    nodePackages.livedown
    nodejs
    obconf
    p7zip
    parted
    pasystray
    pavucontrol
    poppler_utils
    psmisc
    ranger
    rxvt_unicode-with-plugins
    scrot
    shared_mime_info
    shellcheck
    # shotwell
    st
    sshfs
    # stack2nix
    # taffybar
    termite
    tint2
    tmux
    transmission_gtk
    trayer
    tree
    unrar
    unzip
    usbutils
    vlc
    w3m
    wget
    xdg_utils
    xkb-switch
    xmobar
    xsel
    xterm
    yarn
  ];

  zramSwap.enable = true;

  # Enable sound.
  sound.enable = true;

  hardware = {
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

  services.printing.enable = true;

  services.xserver = {
    enable = true;
    layout = "us,th";
    xkbOptions = "grp:lalt_lshift_toggle,caps:swapescape";

    # videoDrivers = [ "nvidiaLegacy340" ];
    videoDrivers = [ "nouveau" ];

    windowManager.openbox.enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = (p: with p; [
      ]);
    };

    windowManager.default = "xmonad";

    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
    };
  };

  users.users.wizzup = {
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
        haskellPackages.steeloverseer
        nodePackages.livedown

        ## TODO: move to custom nvim override
        ## need for nvim's coc
        yarn
        nodejs

        ## need for ranger preview
        ffmpegthumbnailer
        poppler_utils
        w3m

        ## graphical apps
        # neovim-qt
        chromium
        firefox
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

  #   game = {
  #     isNormalUser = true;
  #     home = "/home/game";
  #     description = "game";
  #     packages = [
  #       # steam
  #     ];
  # };

  system.stateVersion = "19.03";

}
