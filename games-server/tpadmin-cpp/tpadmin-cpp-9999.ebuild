# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://git.thousandparsec.net/git/tpadmin-cpp.git"
EGIT_BRANCH="master"
EGIT_BOOTSTRAP="./autogen.sh"

inherit git eutils games

DESCRIPTION=""
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""

DEPEND=">=dev-libs/libtprl-0.1.2
        >=dev-games/libtpproto-cpp-0.2.0
		dev-libs/boost"
RDEPEND="${DEPEND}"

src_compile() {
	egamesconf ${myconf} || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README

	prepgamesdirs
}
