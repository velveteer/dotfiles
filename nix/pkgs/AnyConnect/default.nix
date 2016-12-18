let
  pkgs = import <nixpkgs> {};

  inherit (pkgs) stdenv buildFHSUserEnv;

  AnyConnect = stdenv.mkDerivation {
    name = "anyconnect-linux";
    builder = ./builder.sh;
    src = ./vpnagentd;
  };

in buildFHSUserEnv {
  name = "anyconnect";
  targetPkgs = pkgs: [ AnyConnect ];
  runScript = "anyconnect";
}
