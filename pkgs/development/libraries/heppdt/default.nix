{ stdenv, fetchurl }:

let
  version = "3.04.01";
  name = "heppdt-${version}";
in stdenv.mkDerivation {
  inherit name;
  inherit version;

  src = fetchurl {
    url = "http://lcgapp.cern.ch/project/simu/HepPDT/download/HepPDT-${version}.tar.gz";
    sha256 = "1xn0ccpp4pgxbxr7pqydy31mpd8wifiz3lz0d7nksp99j7mkj71c";
  };

  enableParallelBuilding = true;

  meta = {
    homepage = http://lcgapp.cern.ch/project/simu/HepPDT/;
    description = "Library to provide provide access to the HEP Particle Data Table";
    platforms = stdenv.lib.platforms.all;
  };
}
