# Copyright 2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header$

ESVN_REPO_URI="https://pygccxml.svn.sourceforge.net/svnroot/pygccxml"

inherit distutils subversion

DESCRIPTION="pygccxml"
HOMEPAGE="http://sf.net/projects/pygccxml/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="dev-lang/python
        dev-cpp/gccxml"
DEPEND="${RDEPEND}"

# should be automatic: S=${WORKDIR}/${PN}

# start python setup.py in  pygccxml_dev:
MY_S="${S}/pygccxml_dev"

src_compile () {
	cd ${MY_S}
	distutils_src_compile
}

src_install () {
	cd ${MY_S}
	distutils_src_install
}
