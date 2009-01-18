# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://git.thousandparsec.net/git/libtpproto-cpp.git"
EGIT_BRANCH="master"
EGIT_BOOTSTRAP="./autogen.sh"

inherit git eutils games

DESCRIPTION="A C++ protocol library for Thousand Parsec game clients"
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE="doc gnutls"

DEPEND="dev-libs/boost
        doc? ( app-doc/doxygen )
		gnutls? ( >=net-libs/gnutls-1.2.10 )"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
}

src_compile() {
	econf \
		$(use_enable gnutls) \
		|| die "econf failed"
	emake || die "emake failed"

	if use doc; then
		make doc || ewarn "make doc failed".
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
	if use doc; then
		insinto /usr/share/doc/${PF}
		dohtml -r docs/html/*
	fi
}

