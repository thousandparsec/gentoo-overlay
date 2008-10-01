# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.3

inherit distutils eutils python games

DESCRIPTION="A Python server for Thousand Parsec games"
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI="mirror://sourceforge/thousandparsec/${P}.tar.gz
		http://www.thousandparsec.net/tp/downloads/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/python
	    dev-python/setuptools"
RDEPEND="virtual/python
	     dev-games/libtpproto-py
		 dev-python/mysql-python"

pkg_setup() {
	games_pkg_setup
}

src_install() {
	dodoc API README TODO

	exeinto "$(games_get_libdir)"/${PN}
	doexe config.py server.py tool.py turn.py || die "doexe src failes"

	rm config.py server.py tool.py turn.py API README TODO

	insinto "$(games_get_libdir)"/${PN}
	doins -r * || die "doins src failes"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	python_mod_optimize "${ROOT}$(games_get_libdir)"/${PN}
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}$(games_get_libdir)"/${PN}
}
