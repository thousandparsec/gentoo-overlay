# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.3

inherit distutils eutils python games

DESCRIPTION="A Python client for Thousand Parsec 4X strategy games"
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI="mirror://sourceforge/thousandparsec/${P}.tar.bz2
		http://www.thousandparsec.net/tp/downloads/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnome +pygame +imaging"

DEPEND="virtual/python
	dev-python/setuptools"
RDEPEND="virtual/python
	>=dev-games/libtpclient-py-0.3.1
	>=dev-python/wxpython-2.8.0
	dev-python/numpy
	pygame? ( dev-python/pygame )
	imaging? ( dev-python/imaging )
	gnome? ( dev-python/gnome-python )"

pkg_setup() {
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm setup.py
}

src_install() {
	exeinto "$(games_get_libdir)"/${PN}
	doexe tpclient-pywx || die "doexe src failed"
	insinto "$(games_get_libdir)"/${PN}
	doins *.py || die "doins src failed"
	insinto "$(games_get_libdir)"/${PN}/extra
	doins -r extra/* || die "doins src failed"
	insinto "$(games_get_libdir)"/${PN}/windows
	doins -r windows/* || die "doins src failed"

	insinto "${GAMES_DATADIR}"/${PN}/graphics
	doins graphics/* || die "doins graphics failed"
	insinto "${GAMES_DATADIR}"/${PN}/doc
	doins doc/tips.txt || die "doins doc failed"

	mv doc/tp-pywx-installed doc/tp-pywx-installed-t
	sed s%..CODEPATH..%"$(games_get_libdir)"/${PN}%g doc/tp-pywx-installed-t | \
	sed s%..GRAPHICSPATH..%"${GAMES_DATADIR}"/${PN}/graphics%g | \
	sed s%..DOCPATH..%"${GAMES_DATADIR}"/${PN}/doc%g > doc/tp-pywx-installed
	dogamesbin doc/tp-pywx-installed

	dodoc AUTHORS README TODO
	doicon graphics/tp-icon-32x32.png
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	python_mod_optimize "${ROOT}$(games_get_libdir)"/${PN}
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}$(games_get_libdir)"/${PN}
}
