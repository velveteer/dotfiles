# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware = {
    pulseaudio.enable = true;
  };

  networking.hostName = "shodan"; # Define your hostname.
  networking.networkmanager.enable = true;

  environment.shells = [
    "${pkgs.zsh}/bin/zsh"
  ];

  time.timeZone = "US/Central";

  services.ntp = {
    enable = true;
    servers = [ "server.local" "0.pool.ntp.org" "1.pool.ntp.org" "2.pool.ntp.org" ];
  };

  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium flashplayer
    compton
    conky
    curl
    docker
    dunst
    git
    i3lock
    i3status
    parcellite
    pavucontrol
    redshift
    rofi
    stow
    termite
    tmux
    unclutter
    vim
    wget
    xorg.xbacklight
    xclip
    zsh
  ] ++ (with python27Packages; [
    docker_compose
    udiskie
  ]);

  # NOTE: changes to this take effect on login.
  environment.sessionVariables = {
    EDITOR = "vim";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
      enableGoogleTalkPlugin = true;
      enablePepperFlash = true;
      enablePepperPDF = true;
    };

    vim = {
      lua = true;
    };

    programs = {
      bash.enableCompletion = true;
      zsh.enable = true;
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      hack-font
      terminus_font
    ];
  };

  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.desktopManager.default = "none";

  services.xserver.windowManager = {
    default = "i3";
    i3.enable = true;
  };

  services.xserver.synaptics.enable = true;

  # Define a user account. Don't forget to set a password with `passwd`.
  users.extraUsers.josh = {
    name = "josh";
    extraGroups = [ "wheel" "networkmanager" ];
    uid = 1000;
    createHome = true;
    home = "/home/josh";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}
