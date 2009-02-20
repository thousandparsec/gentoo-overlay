# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils eutils

DESCRIPTION="A Python protocol library for Thousand Parsec game clients/servers"
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI="mirror://sourceforge/thousandparsec/${P}.tar.bz2
		http://www.thousandparsec.net/tp/downloads/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc ssl"

RDEPEND=">=dev-lang/python-2.3
		 ssl? ( dev-python/pyopenssl )"
DEPEND="${RDEPEND}
	    dev-python/setuptools"

src_install() {
	distutils_src_install
	rm -f "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/*.pth
	# evil fix
	touch "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/tp/__init__.py
}
