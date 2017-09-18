{ stdenv, fetchurl, fetchpatch, cmake, pcre, pkgconfig, python
, libX11, libXpm, libXft, libXext, mesa, zlib, libxml2, lzma, gsl
, Cocoa, OpenGL, xrootd, fftw, postgresql, mysql, sqlite, gfortran
, openssl, graphviz, openldap, cfitsio, ftgl, tbb }:

stdenv.mkDerivation rec {
  name = "root-${version}";
  version = "6.10.04";

  src = fetchurl {
    url = "https://root.cern.ch/download/root_v${version}.source.tar.gz";
    sha256 = "0nwg4bw02v6vahm2rwfaj7fzp3ffhjg5jk7h20il4246swhxw6s6";
  };

  buildInputs = [ cmake pcre pkgconfig python zlib libxml2 lzma gsl xrootd
                  fftw postgresql mysql sqlite gfortran openssl tbb
                  graphviz openldap cfitsio ftgl ]
    ++ stdenv.lib.optionals (!stdenv.isDarwin) [ libX11 libXpm libXft libXext mesa ]
    ++ stdenv.lib.optionals (stdenv.isDarwin) [ Cocoa OpenGL ]
    ;

  patches = [
    ./sw_vers.patch

    # this prevents thisroot.sh from setting $p, which interferes with stdenv setup
    ./thisroot.patch

    # https://sft.its.cern.ch/jira/browse/ROOT-8728
    ./ROOT-8728-extra.patch
  ];

  preConfigure = ''
    patchShebangs build/unix/
  '';

  cmakeFlags = [
    "-Drpath=ON"
    "-DCMAKE_INSTALL_LIBDIR=lib"
    "-DCMAKE_INSTALL_INCLUDEDIR=include"
    "-Dalien=OFF"
    "-Dbonjour=OFF"
    "-Dcastor=OFF"
    "-Dchirp=OFF"
    "-Ddavix=OFF"
    "-Ddcache=OFF"
    "-Dfftw3=ON"
    "-Dfitsio=ON"
    "-Dfortran=ON"
    "-Dimt=ON"
    "-Dgfal=OFF"
    "-Dgviz=ON"
    "-Dhdfs=OFF"
    "-Dkrb5=OFF"
    "-Dldap=ON"
    "-Dmonalisa=OFF"
    "-Dmysql=ON"
    "-Dodbc=OFF"
    "-Dopengl=ON"
    "-Doracle=OFF"
    "-Dpgsql=ON"
    "-Dpythia6=OFF"
    "-Dpythia8=OFF"
    "-Drfio=OFF"
    "-Dsqlite=ON"
    "-Dssl=ON"
    "-Dxml=ON"
    "-Dxrootd=ON"
    "-Dfail-on-missing=ON"
    "-Dpython3=${if python ? isPy3 then "ON" else "OFF"}"
  ]
  ++ stdenv.lib.optional (stdenv.cc.libc != null) "-DC_INCLUDE_DIRS=${stdenv.lib.getDev stdenv.cc.libc}/include"
  ++ stdenv.lib.optional stdenv.isDarwin "-DOPENGL_INCLUDE_DIR=${OpenGL}/Library/Frameworks";

  enableParallelBuilding = true;

  setupHook = ./setup-hook.sh;

  meta = {
    homepage = https://root.cern.ch/;
    description = "A data analysis framework";
    platforms = stdenv.lib.platforms.unix;
    maintainers = with stdenv.lib.maintainers; [ veprbl ];
  };
}
