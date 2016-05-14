with import <nixpkgs> {}; {
  sdlEnv = stdenv.mkDerivation {
    name = "sdl";
    shellHook = ''
      export PS1="sdl2 > "
      '';
    buildInputs = [ stdenv SDL2 SDL2_image SDL2_ttf SDL2_gfx cmake SDL2_net pkgconfig ];
  };
}
