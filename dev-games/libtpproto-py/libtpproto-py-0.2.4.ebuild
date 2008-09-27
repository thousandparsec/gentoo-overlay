# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.3

inherit distutils eutils

DESCRIPTION="A Python protocol library for Thousand Parsec game clients/servers"
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI="mirror://sourceforge/thousandparsec/${P}.tar.bz2
		http://www.thousandparsec.net/tp/downloads/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc ssl"

RDEPEND="ssl? ( dev-python/pyopenssl )"
DEPEND="${RDEPEND}
       dev-python/setuptools"

src_install() {
	distutils_src_install
}
