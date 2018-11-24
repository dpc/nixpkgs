{ stdenv, fetchFromGitHub, ncurses, asciidoc, docbook_xsl, libxslt, pkgconfig }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "kakoune-unstable-${version}-dpc";
  version = "2018.11.23";
  src = fetchFromGitHub {
    repo = "kakoune";
    owner = "dpc";
    rev = "71b8ed1600115b14bd2d8e1128ea8725bc725da0";
    sha256 = "0rpqi3rq16kbba8nl44y6w7f5ki4hwndlzr9mq20j46xc5vxmw88";
  };
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ ncurses asciidoc docbook_xsl libxslt ];
  makeFlags = [ "debug=no" ];

  postPatch = ''
    export PREFIX=$out
    cd src
    sed -ie 's#--no-xmllint#--no-xmllint --xsltproc-opts="--nonet"#g' Makefile
  '';

  preConfigure = ''
    export version="v${version}"
  '';

  meta = {
    homepage = http://kakoune.org/;
    description = "A vim inspired text editor";
    license = licenses.publicDomain;
    maintainers = with maintainers; [ vrthra ];
    platforms = platforms.unix;
  };
}
