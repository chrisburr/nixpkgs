{stdenv, fetchurl, tcl, x11}:

stdenv.mkDerivation {
  name = "tk-8.4.13";
  builder = ./builder.sh;
  src = fetchurl {
    url = http://nix.cs.uu.nl/dist/tarballs/tk8.4.13-src.tar.gz;
    md5 = "0a16d4d9398e43cbb85784c85fb807a4";
  };
  buildInputs = [tcl x11];
  inherit tcl;
}
