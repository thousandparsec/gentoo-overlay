# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A C++ protocol library for Thousand Parsec game clients"
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI="mirror://sourceforge/thousandparsec/${P}.tar.gz
		http://www.thousandparsec.net/tp/downloads/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 sparc"
IUSE="doc gnutls"
DEPEND="dev-libs/boost
        doc? ( app-doc/doxygen )
        gnutls? ( >=net-libs/gnutls-1.2.10 )"
RDEPEND="${DEPEND}"

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
