{ stdenv, fetchurl, fetchpatch, cmake, pcre, pkgconfig, python27, python34,
  python35, python36, openssl, libxml2, readline, fuse, krb5Full }:

stdenv.mkDerivation rec {
  name = "xrootd-${version}";
  version = "4.7.0";

  src = fetchurl {
    url = "https://github.com/xrootd/xrootd/archive/v${version}.tar.gz";
    sha256 = "1gvagn45yy99dbdc8bac1mdf0rixb6pzywa60bw98pjw1jzdv1f4";
  };

  buildInputs = [ cmake pcre pkgconfig python27 python34 python35 python36
                  openssl libxml2 readline krb5Full fuse ];

  patches = [ ./many_python_versions.patch ];

  # For some reason libXrdUtils isn't properly linked to $out/lib
  postFixup = ''
    rp=$(patchelf --print-rpath $out/lib/libXrdUtils.so)
    patchelf --set-rpath $rp:$out/lib $out/lib/libXrdUtils.so
  '';

  enableParallelBuilding = true;

  meta = {
    homepage = "http://www.xrootd.org/";
    description = "";
    platforms = stdenv.lib.platforms.unix;
    maintainers = with stdenv.lib.maintainers; [ chrisburr ];
  };
}
