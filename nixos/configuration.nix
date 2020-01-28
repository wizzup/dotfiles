# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
        enable = true;
        version = 2;
        device = "/dev/disk/by-id/wwn-0x50014ee1002d4ea2";

        # memtest86.enable = true;
  };

  networking = {
    useDHCP = false;
    enableIPv6 = false;
    hostName = "earth";
    defaultGateway = "192.168.1.1";
    nameservers = ["8.8.8.8" "8.8.4.4"];
    interfaces.enp0s7 = {
      ipv4.addresses = [{ address = "192.168.1.4"; prefixLength = 24; }];
    };
  };

  i18n = {
    # console.KeyMap = "us";
    # consoleFont = "Lat2-Terminus16";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Asia/Bangkok";

  nix = {
    # maxJobs = 2;
    # useSandbox = false;

    # default level is 0, valid values are 0 to 19
    # daemonNiceLevel = 18;

    # default level is 0, valid values are 0 to 7
    # daemonIONiceLevel = 6;

    binaryCaches = [
      "https://cache.nixos.org"

      "https://wizzup.cachix.org"
      "https://hercules-ci.cachix.org"
      "https://all-hies.cachix.org"
      "https://haskell-miso.cachix.org"

      "https://nixcache.reflex-frp.org"
    ];

    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

      "wizzup.cachix.org-1:FDHBjAYzhSSGmX3ZGIhgl3+uwNFblIOzjPTb0edaVOw="
      "hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0="
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
      "haskell-miso.cachix.org-1:JU8k0o/s0G/LtD43BTkrIuLX8NfKktgq7MkgrCdtG6o="

      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];

    trustedUsers = [ "root" "wizzup" ];

    gc.automatic = true;
    gc.options = "--delete-older-than 30d";
  };

  nixpkgs = {
    system = "x86_64-linux";

    config.allowUnfree = true;
    # config.allowBroken = true;

    overlays = [
      # (import /data/works/dotfiles/nixpkgs/overlays/neovim.nix)
      (import /data/works/dotfiles/nixpkgs/overlays/st.nix)
      (import /data/works/dotfiles/nixpkgs/overlays/ranger.nix)
    ];
  };

  virtualisation = {
    # anbox.enable = true;

    # docker.enable = true;
    # docker.autoPrune.enable = true;

    # libvirtd.enable = true;

    # virtualbox.host.enable = true;
    # virtualbox.host.enableExtensionPack = true;
  };


  ## documentations
  documentation.dev.enable = true;

  ##  fonts
  fonts = {
    enableDefaultFonts = true;

    fonts = [
      tlwg
      source-code-pro
      # fira-code

      # noto-fonts
      # noto-fonts-extra
      # noto-fonts-emoji
      # noto-fonts-cjk
    ];
  };

  ## programs
  programs = {
    evince.enable = true;
    file-roller.enable = true;
    gnome-disks.enable = true;
    less.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # libreoffice-fresh
    # shared_mime_info
    # shotwell
    # stack2nix
    # taffybar
    alacritty
    alsaUtils
    arc-icon-theme
    btrfs-progs
    cabal-install
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
    ghostscript
    git
    gitAndTools.gitFull
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
    htop
    inotify-tools
    kakoune
    keepassx2
    kitty
    libreoffice
    lm_sensors
    neovim
    nodePackages.live-server
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
    shotwell
    sshfs
    st
    stack
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
    vagrant
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
    # enableAllFirmware = true;

    # sound via PulseAudio
    pulseaudio = {
      enable = true;
      # support32Bit = true;

      # pulseaudioLight does *not* have module-x11-publish.so
      # https://github.com/NixOS/nixpkgs/issues/11970
      package = pulseaudioFull;
    };

    # nvidia.modesetting.enable = true;

    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
  };

  services = {

    # printing.enable = true;

    gnome3 = {
      # sushi.enable = true;
      # at-spi2-core.enable = true;
    };

    openssh.enable = true;

    xserver = {
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

      displayManager.defaultSession = "none+xmonad";

      # windowManager.default = "xmonad";
      # displayManager.sddm = {
      #   enable = true;
      #   autoNumlock = true;
      # };
    };

  };

  users.users = {
    john = {
      isNormalUser = true;
    };

    jane = {
      isNormalUser = true;
    };

    wizzup = {
      isNormalUser = true;
        home = "/home/wizzup";
        description = "wizzup";
        extraGroups = [
          "audio"
          "docker"
          "libvirtd"
          "vboxusers"
          "wheel"
        ];
        packages = [
          ];
        };
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
