# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = [ pkgs.vaapiIntel ];
  };

  networking.hostName = "shodan"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "US/Pacific";

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

  environment = {
    systemPackages = with pkgs; [
      compton
      curl
      dunst
      git
      htop
      i3lock
      i3status
      iotop
      lsof
      lua5
      parcellite
      pavucontrol
      python
      rofi
      stow
      termite
      tmux
      unclutter
      vimHugeX
      wget
      xorg.xbacklight
      xclip
      zsh
    ] ++ (with python27Packages; [
      docker_compose
      udiskie
    ]);
    shells = [
      "${pkgs.zsh}/bin/zsh"
    ];
    sessionVariables = {
      EDITOR = "vim";
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };

  services.ntp.enable = true;

  services.acpid.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.

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
        ${pkgs.compton}/bin/compton -b &
        ${pkgs.networkmanagerapplet}/bin/nm-applet &
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

  services.upower.enable = true;

  # Define a user account. Don't forget to set a password with `passwd`.
  users.extraUsers.josh = {
    name = "josh";
    extraGroups = [ "wheel" "networkmanager" "docker"];
    uid = 1000;
    createHome = true;
    home = "/home/josh";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  security.sudo.wheelNeedsPassword = false;

  # Enable Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # Fonts
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;

    fonts = with pkgs; [
      corefonts
      anonymousPro
      aurulent-sans
      bakoma_ttf
      cantarell_fonts
      crimson
      dejavu_fonts
      dina-font
      dosemu_fonts
      fantasque-sans-mono
      fira
      fira-code
      fira-mono
      freefont_ttf
      hack-font
      hasklig
      inconsolata
      liberation_ttf
      meslo-lg
      powerline-fonts
      proggyfonts
      source-code-pro
      source-sans-pro
      source-serif-pro
      terminus_font
      tewi-font
      ttf_bitstream_vera
      ubuntu_font_family
      unifont
      vistafonts
      xlsfonts
    ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";
}
