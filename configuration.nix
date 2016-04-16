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

  networking.hostName = "shodan"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
		alsaLib alsaPlugins alsaUtils
		chromium flashplayer
		compton
		conky
		curl
		dmenu
		dunst
		git
		i3status
		parcellite
		redshift
		rofi
		stow
		termite
		tmux
		unclutter
		vim
		wget 
		xclip
		zsh
  ];

	# NOTE: changes to this take effect on login.
	environment.sessionVariables = {
		EDITOR = "vim";
		NIXPKGS_ALLOW_UNFREE = "1";
	};

  nixpkgs.config = {
		allowUnfree = true;

		chromium = {
			enablePepperFlash = true;
			enablePepperPDF = true;
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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
	services.xserver.desktopManager.default = "none";

  services.xserver.windowManager = {
		default 			= "i3";
		i3.enable     = true;
	};

  services.xserver.synaptics.enable = true;

	# Define a user account. Don't forget to set a password with `passwd`.
	users.extraUsers.jason = {
		name = "josh";
    extraGroups = [ "wheel" "networkmanager" ];
		uid = 1001;
		createHome = true;
		home = "/home/josh";
		shell = "${pkgs.zsh}/bin/zsh";
	};

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}
