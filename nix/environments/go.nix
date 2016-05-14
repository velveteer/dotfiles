with import <nixpkgs> {}; {
  goEnv = stdenv.mkDerivation {
    name = "go";
    shellHook = ''
      export GOPATH=$HOME/go
      export PATH=$PATH:$GOPATH/bin
      export PS1="go > "
      '';
    buildInputs = [ go ];
  };
}
