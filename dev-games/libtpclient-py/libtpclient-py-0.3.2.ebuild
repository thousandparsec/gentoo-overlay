# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils eutils

DESCRIPTION="A Python library for development of Thousand Parsec game clients"
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI="mirror://sourceforge/thousandparsec/${P}.tar.bz2
		http://www.thousandparsec.net/tp/downloads/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.3
		 >=dev-games/libtpproto-py-0.2.5"
DEPEND="${RDEPEND}
	    dev-python/setuptools"

src_install() {
	distutils_src_install
	rm -f "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/*.pth
}
