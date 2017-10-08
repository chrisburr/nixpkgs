{ stdenv, fetchgit }:

let
  version = "2.3.4.5";
  name = "clhep-${version}";
in stdenv.mkDerivation {
  inherit name;

  src = fetchgit {
    url = "https://gitlab.cern.ch/CLHEP/CLHEP.git";
    rev = "9e3dd671d22c535c2b373479be333ef0aa89af7f";
  };

  preConfigure = ''
    ./bootstrap
  '';

  enableParallelBuilding = true;

  meta = {
    homepage = https://proj-clhep.web.cern.ch/proj-clhep/;
    description = "A Class Library for High Energy Physics";
    license = stdenv.lib.licenses.lgpl3;
    platforms = stdenv.lib.platforms.all;
  };
}
