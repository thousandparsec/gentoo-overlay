# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.3

inherit distutils eutils python games

DESCRIPTION="An advanced rule based AI for Thousand Parsec."
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI="mirror://sourceforge/thousandparsec/${P}.tar.bz2
		http://www.thousandparsec.net/tp/downloads/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/python
	dev-python/setuptools"
RDEPEND="virtual/python
	>=dev-games/libtpclient-py-0.3.1-r1
	dev-python/logilab-constraint"

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
	doexe daneel-ai || die "doexe src failed"
	insinto "$(games_get_libdir)"/${PN}
	doins *.py || die "doins src failed"
	insinto "$(games_get_libdir)"/${PN}/rules
	doins rules/* || die "doins rules failed"

	insinto "${GAMES_DATADIR}"/tp/aiclients
	doins daneel-ai.xml

	sed s%..CODEPATH..%"$(games_get_libdir)"/${PN}%g ${FILESDIR}/daneel-ai \
	> ${WORKDIR}/daneel-ai
	dogamesbin ${WORKDIR}/daneel-ai

	dodoc AUTHORS README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	python_mod_optimize "${ROOT}$(games_get_libdir)"/${PN}
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}$(games_get_libdir)"/${PN}
}
