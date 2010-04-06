# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Python plugin for Verlihub"
HOMEPAGE="http://www.verlihub-project.org"
SRC_URI="mirror://sourceforge/verlihub/python.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86-fbsd x86"
DEPEND="net-p2p/verlihub"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack "python.tar.gz"
	cd "${S}"
	epatch "${FILESDIR}/cpipython.cpp.patch"
}

src_compile() {
        econf || die
        emake || die "Make failed for problems or bugs please visit http://forums.verlihub-project.org/viewforum.php?f=36"
}

 src_install() {
         make DESTDIR=${D} install || die
 
 }
 
 pkg_postinst() {
     	einfo "Python is now installed, please run it using !onplug python or!plugin /usr/local/lib/libpython_pi.so"
        ewarn "Do NOT report bugs to Gentoo's bugzilla"
        einfo "Please report all bugs to http://forums.verlihubproject.org/viewforum.php?f=36"
        einfo "Verlihub-project team"
}

