# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.3

inherit distutils eutils python games

DESCRIPTION="A Python Ogre 3D client for Thousand Parsec 4X strategy games"
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI="http://thousandparsec.net/tp/downloads/tpclient-pyogre/tpclient-pyogre-0.0.1.tar.gz
		 http://sourceforge.net/project/downloading.php?group_id=132078&filename=tpclient-pyogre-0.0.1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/python
		 >=dev-games/libtpclient-py-0.3.1
		 dev-games/python-ogre"

