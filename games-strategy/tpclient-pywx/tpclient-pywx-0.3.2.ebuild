# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=yeah

inherit distutils-r1 eutils

DESCRIPTION="A Python client for Thousand Parsec 4X strategy games"
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI="mirror://sourceforge/thousandparsec/${P}.tar.bz2
		http://www.thousandparsec.net/tp/downloads/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnome +pygame +imaging"

DEPEND="
	dev-python/setuptools"
RDEPEND="
	>=dev-games/libtpclient-py-0.3.2
	>=dev-python/wxpython-2.8.0
	dev-python/numpy
	pygame? ( dev-python/pygame )
	imaging? ( dev-python/pillow )
	gnome? ( dev-python/gnome-python )"

src_install() {
	distutils-r1_python_install --prefix="$D/usr"
}
