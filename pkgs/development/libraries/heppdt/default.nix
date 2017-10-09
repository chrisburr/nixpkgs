{ stdenv, fetchurl, automake, autoconf, ghostscript }:

let
  version = "2.06.01";
  name = "heppdt-${version}";
in stdenv.mkDerivation {
  inherit name;
  inherit version;

  src = fetchurl {
    # url = "http://lcgapp.cern.ch/project/simu/HepPDT/download/HepPDT-3.04.01.tar.gz";
    # sha256 = "1xn0ccpp4pgxbxr7pqydy31mpd8wifiz3lz0d7nksp99j7mkj71c";
    url = "http://lcgapp.cern.ch/project/simu/HepPDT/download/HepPDT-${version}.tar.gz";
    sha256 = "0bicg9380j61p8adckvd7f7nz8wmdr7z8w2d7gx06rk2vpzvd88j";
  };

  preConfigure = ''
    ./bootstrap
  '';

  buildInputs = [ automake autoconf ghostscript ];

  enableParallelBuilding = true;

  meta = {
    homepage = http://lcgapp.cern.ch/project/simu/HepPDT/;
    description = "Library to provide provide access to the HEP Particle Data Table";
    platforms = stdenv.lib.platforms.all;
  };
}
