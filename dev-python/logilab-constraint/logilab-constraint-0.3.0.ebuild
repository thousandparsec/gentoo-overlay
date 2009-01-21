# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_P=${P#logilab-}
DESCRIPTION="A finite domain constraints solver written in 100% pure Python"
HOMEPAGE="http://www.logilab.org/projects/constraint/"
SRC_URI="http://ftp.logilab.org/pub/constraint/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DOCS="doc/CONTRIBUTORS"
PYTHON_MODNAME="logilab/constraint"

DEPEND=""
RDEPEND=">=dev-python/logilab-common-0.12.0"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/${P}-future.patch
}

src_install() {
	distutils_src_install
	
	# avoid conflict with dev-python/logilab-common:
	rm -f ${D}usr/$(get_libdir)/python*/site-packages/logilab/__init__.py

	if use doc; then
		dohtml doc/documentation.html
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	if use x86 && ! has_version dev-python/psyco ; then
		einfo ""
		einfo "Although it is not required, you should consider installing"
		einfo "\"dev-python/psyco\". It can speed up this module a lot."
		einfo ""
	fi
}
