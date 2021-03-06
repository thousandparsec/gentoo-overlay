# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.5

inherit distutils python

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
	>=dev-games/libtpproto-py-0.2.4
	dev-python/logilab-constraint"

src_install() {
	distutils_src_install
	dodoc AUTHORS README TODO
}
