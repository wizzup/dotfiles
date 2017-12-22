# NixOS configuration file for earth by wizzup
# /etc/nixos/configuration.nix

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
    enable = true;
    version = 2;

    device = "/dev/sda";
  };

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
        ipAddress = "192.168.1.4";
        prefixLength = 24;
      };
  };

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Asia/Bangkok";

  # nix.useSandbox = true;
  # nix.binaryCaches = [ "https://cache.nixos.org" "https://nixcache.reflex-frp.org" ];
  # nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

  nixpkgs = {
    system = "x86_64-linux";

    config.allowUnfree = true;
    # config.virtualbox.enableExtensionPack = true;
  };

  programs.bash.enableCompletion = true;
  programs.command-not-found.enable = true;

  environment.systemPackages = with pkgs; [
    ## terminal apps
    btrfs-progs
    htop
    file
    gcc
    git
    gnumake
    neovim
    p7zip
    tmux
    tree
    unzip
    wget
    xsel
    jre

    ## graphical apps
    # firefox-devedition-bin
    # gnucash26
    chromium
    ffmpegthumbnailer
    firefox
    gnucash
    keepassx2
    libreoffice-fresh
    neovim-qt
    scrot
    transmission_gtk
    vlc

    gnome2.gnome_icon_theme
    gnome3.gconf
    gnome3.nautilus
    gnome3.evince
    gnome3.dconf-editor
    gnome3.file-roller
    gnome3.gnome-disk-utility
    gnome3.gnome_control_center
    hicolor_icon_theme
    shared_mime_info

    ## xmonad utils
    dmenu
    dzen2
    gmrun
    lm_sensors
    termite
    rxvt_unicode
    trayer
    pasystray
    dunst

    ## haskell packages
    haskellPackages.xmobar

    # openbox utils
    obconf

    ## fonts
    google-fonts
    # dejavu_fonts
    # noto-fonts

  ];

  # services = {
    # ipfs.enable = true;
    # openssh.enable = true;
  # };

  services.printing = {
    enable = true;
    drivers = [ pkgs.samsung-unified-linux-driver ];
  };

  services.dbus.packages = [ pkgs.gnome3.dconf ];

  services.udisks2.enable = true;

  services.gnome3 = {
    sushi.enable = true;
    gvfs.enable = true;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=50M
    MaxRetentionSec=10day
    '';

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver = {
        enable = true;
        layout = "us, th";
        xkbOptions = "grp:lalt_lshift_toggle, caps:swapescape";

        videoDrivers = [ "nvidiaLegacy340" ];

        xrandrHeads = [
          { output = "DVI-I-1";}
          { output = "DVI-I-2";}
        ];

        # windowManager.openbox.enable = true;

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
      extraGroups = ["wheel" "docker" "vboxusers"];
    };

    game = {
      isNormalUser = true;
      home = "/home/game";
      description = "game";
    };
  };
}
