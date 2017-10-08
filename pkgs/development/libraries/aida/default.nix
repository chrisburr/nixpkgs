{ stdenv, fetchurl }:

let
  version = "3.2.1";
  name = "aida-${version}";
in stdenv.mkDerivation {
  inherit name;
  inherit version;

  src = fetchurl {
    url = "ftp://ftp.slac.stanford.edu/software/freehep/AIDA/v${version}/aida-${version}-src.tar.gz";
    sha256 = "10ac66l3sdj7s3hgncgyivpq4nmg8jzjqajixgi0m0wyq0dkabc8";
  };

  phases = [ "unpackPhase" "installPhase" ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
  '';

  enableParallelBuilding = true;

  meta = {
    homepage = http://aida.freehep.org/;
    description = "Abstract Interfaces for Data Analysis";
    license = stdenv.lib.licenses.lgpl2;
    platforms = stdenv.lib.platforms.all;
  };
}
