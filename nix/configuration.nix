{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

  # EFI bootstrap config
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = [ pkgs.vaapiIntel ];
    opengl.extraPackages32 = [ pkgs.vaapiIntel ];
  };

  # Hostname and network-manager
  networking.hostName = "shodan";
  networking.networkmanager.enable = true;

  time.timeZone = "US/Pacific";

  # System nix config
  nixpkgs.config = {
    allowUnfree = true;

    vim = {
      lua = true;
      python = true;
    };

    programs = {
      zsh.enable = true;
    };

    packageOverrides = pkgs: {
      bluez = pkgs.bluez5;
    };
  };

  # System packages
  environment = {
    systemPackages = with pkgs; [
      compton curl dunst git htop i3lock i3status iotop lsof
      parcellite pavucontrol python rofi stow termite tmux
      unclutter vimHugeX wget xorg.xbacklight xclip zsh
    ] ++ (with python27Packages; [ docker_compose udiskie ]);
    shells = [
      "${pkgs.zsh}/bin/zsh"
    ];
    sessionVariables = {
      EDITOR = "vim";
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };

  # NTP
  services.ntp.enable = true;

  # Power management (e.g. suspend on lid close)
  services.acpid.enable = true;
  services.upower.enable = true;

  # Redshift
  services.redshift.enable = true;
  services.redshift.brightness.day = "0.95";
  services.redshift.brightness.night = "0.7";
  services.redshift.latitude = "45";
  services.redshift.longitude = "122";

  # Enable Docker and use btrfs
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # Xorg configuration
  services.xserver = {
    enable = true;
    layout = "us";

    synaptics = {
       enable = true;
       minSpeed = "0.1";
       maxSpeed = "15";
       accelFactor = "0.8";

       tapButtons = false;
       palmDetect = true;

       twoFingerScroll = true;
       vertEdgeScroll = false;
       horizontalScroll = true;

       additionalOptions = ''
         # "Natural" scrolling
         Option "VertScrollDelta" "-30"
         Option "HorizScrollDelta" "-30"
         Option "EmulateMidButtonTime" "100"
         '';
    };

    displayManager = {
      slim = {
        enable = true;
        autoLogin = false;
        defaultUser = "josh";
        theme = pkgs.fetchurl {
          url = "mirror://sourceforge/slim.berlios/slim-rear-window.tar.gz";
          sha256 = "0b123706ccb67e94f626c183530ec5732b209bab155bc661d6a3f5cd5ee39511";
        };
      };
      sessionCommands = ''
        ${pkgs.xlibs.xset}/bin/xset r rate 200 60  # set the keyboard repeat rate
        ${pkgs.feh}/bin/feh --no-fehbg --bg-scale ~/dotfiles/backgrounds/wall.jpg &
        ${pkgs.networkmanagerapplet}/bin/nm-applet &
        ${pkgs.compton}/bin/compton -b &
        ${pkgs.dunst}/bin/dunst &
        ${pkgs.parcellite}/bin/parcellite -n &
        ${pkgs.unclutter}/bin/unclutter -root -visible &
        ${pkgs.python27Packages.udiskie}/bin/udiskie &
      '';
    };

    desktopManager = {
      default = "none";
    };

    windowManager = {
      default = "i3";
      i3.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with `passwd`.
  users.extraUsers.josh = {
    name = "josh";
    extraGroups = [ "wheel" "networkmanager" "docker"];
    uid = 1000;
    createHome = true;
    home = "/home/josh";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  # Don't use this on a server, k?
  security.sudo.wheelNeedsPassword = false;

  # Fonts
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    fonts = with pkgs; [
      corefonts cantarell_fonts hack-font source-code-pro symbola
      terminus_font ubuntu_font_family unifont vistafonts xlsfonts
    ];
  };

}
