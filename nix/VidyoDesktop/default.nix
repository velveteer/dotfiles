let
  pkgs = import <nixpkgs> {};

  inherit (pkgs) stdenv fetchurl buildFHSUserEnv;

  VidyoDesktopDeb = stdenv.mkDerivation {
    name = "VidyoDesktopDeb";
    builder = ./builder.sh;
    dpkg = pkgs.dpkg;
    src = fetchurl {
      url = "https://vidyoportal.cern.ch/upload/VidyoDesktopInstaller-ubuntu64-TAG_VD_3_6_3_017.deb";
      sha256 = "9d2455dc29bfa7db5cf3ec535ffd2a8c86c5a71f78d7d89c40dbd744b2c15707";
    };
    buildInputs = [ pkgs.makeWrapper ];
  };

in buildFHSUserEnv {
  name = "VidyoDesktop";
  targetPkgs = pkgs: [ VidyoDesktopDeb ];
  multiPkgs = pkgs: with pkgs; [
    patchelf dpkg
    alsaLib alsaUtils alsaOss alsaTools alsaPlugins
    libidn utillinux mesa_glu qt4 zlib
    xorg.libXext xorg.libXv xorg.libX11 xorg.libXfixes xorg.libXrandr
    xorg.libXScrnSaver
  ];
  extraBuildCommands = ''
    ln -s ${VidyoDesktopDeb}/opt $out/opt
  '';
  runScript = "VidyoDesktop";
  # for debugging
  #runScript = "bash";
}
