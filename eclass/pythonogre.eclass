# Copyright 2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: pythonogre.eclass
# @MAINTAINER:
# strank(AT)strank(DOT)info
# @BLURB: This eclass provides functions for building parts of python-ogre
# @DESCRIPTION:
# The eclass abstracts the common elements of building python-ogre wrappers
# since building all of them takes a long time.

ESVN_REPO_URI="https://python-ogre.svn.sourceforge.net/svnroot/python-ogre/trunk/python-ogre"

inherit distutils subversion

DESCRIPTION="python-ogre python interface to several 3D and related libraries"
HOMEPAGE="http://www.python-ogre.org/"

LICENSE="Open Software License"
SLOT="0"

if [ ${PN} == "python-ogre" ]; then
    DEPEND=">=dev-lang/python-2.5.2
            >=dev-games/ogre-1.4.7_p99
            =dev-games/ois-1.2.0
            >=dev-util/scons-0.97
            =dev-python/py++-9999"
else
    DEPEND="=dev-games/python-ogre-9999"
fi

RDEPEND="${DEPEND}"

# no version number in source path:
#S=${WORKDIR}/${PN}
S=${WORKDIR}/python-ogre

EXPORT_FUNCTIONS src_unpack src_compile


# @ECLASS-VARIABLE: PYTHONOGRE_COMPONENTS
# @DESCRIPTION:
# The names of the python-ogre wrapper to be built, space separated.
# needs to be defined in inheriting ebuilds!
#PYTHONOGRE_COMPONENTS=""

# this is an ugly hack, but otherwise we have to copy the patches:
PYTHONOGRE_FILESDIR=${FILESDIR/${PN}/python-ogre}

# @FUNCTION: pythonogre_src_unpack
# @DESCRIPTION:
# Applies patches after svn unpack
pythonogre_src_unpack() {
	subversion_src_unpack
	einfo "patching build scripts."
	cd "${S}"
	epatch "${PYTHONOGRE_FILESDIR}"/PythonOgre-*.patch
}

# @FUNCTION: pythonogre_src_compile
# @DESCRIPTION:
# Generate code, then scons, then distutils.
pythonogre_src_compile() {
	cd "${S}"
	einfo "calling code generators for ${PYTHONOGRE_COMPONENTS}."
	for component in ${PYTHONOGRE_COMPONENTS} ; do
		pushd ./code_generators/${component}
		python generate_code.py > build.out || die "code generation for ${component} failed"
		popd
	done
	einfo "calling scons for ${PYTHONOGRE_COMPONENTS}."
        cd "${S}"
	for proj in ${PYTHONOGRE_COMPONENTS} ; do
		scons PROJECTS=$proj install_pypp_txt=1 || die "scons for ${proj} failed"
	done
	einfo "now calling distutils src_compile."
        distutils_src_compile
}
