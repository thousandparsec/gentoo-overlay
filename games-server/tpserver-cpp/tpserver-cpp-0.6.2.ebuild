# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1
inherit eutils games

DESCRIPTION="A C++ server for Thousand Parsec games"
HOMEPAGE="http://www.thousandparsec.net/tp/"
SRC_URI="mirror://sourceforge/thousandparsec/${P}.tar.gz
         http://www.thousandparsec.net/tp/downloads/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 sparc"
IUSE="avahi gnutls mysql +tpadmin"

DEPEND="dev-libs/boost
        || ( >=dev-scheme/guile-1.6 dev-scheme/plt-scheme )
		avahi? ( >=net-dns/avahi-0.6.0 )
		gnutls? ( >=net-libs/gnutls-1.2.10 )
		mysql? ( >=virtual/mysql-4.0 )"
RDEPEND="${DEPEND}
		 tpadmin? ( games-server/tpadmin-cpp )"

src_compile() {
	egamesconf \
		$(use_enable avahi) \
		$(use_enable gnutls) \
		$(use_with mysql) \
		|| die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	keepdir /var/{cache,run}/${PN}

	dodir /etc/${PN}
	insinto /etc/${PN}
	insopts -m 0640 -o root -g games
	doins sample.conf "${FILESDIR}"/tpserver.conf

	prepgamesdirs
	gamesowners /var/{cache,run}/${PN}
}
