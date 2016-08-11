let
  pkgs = import <nixpkgs> {};
  in
{
  allowUnfree = true;
  chromium = {
    enableWideVine = true;
    enablePepperFlash = true;
    enablePepperPDF = true;
    pulseSupport = true;
  };
}
