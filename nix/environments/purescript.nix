with import <nixpkgs> {}; let
runtimeLibs = [ gmp nodejs haskellPackages.stack ghc ncurses ];
libPaths    = map (x: ":${x}/lib") runtimeLibs;
in rec {
  env = stdenv.mkDerivation {
    name            = "purescript";
    buildInputs     = [ stdenv haskellPackages.stack ghc ncurses ];
    LD_LIBRARY_PATH = lib.foldl (x: y: x + y) "" libPaths;
    shellHook = ''
      export PATH=$PATH:$HOME/.local/bin/
      '';
  };
}
