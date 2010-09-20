# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="ISP plugins for Verlihub"
HOMEPAGE="http://www.verlihub-project.org"
SRC_URI="mirror://sourceforge/verlihub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 amd64-fbsd x86 x86-fbsd"
IUSE=""

DEPEND="net-p2p/verlihub"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"
}

src_compile() {
	econf || die
	emake || die "Make failed for problems or bugs please visit http://forums.verlihub-project.org/viewforum.php?f=36"
}

src_install() {
	make DESTDIR="${D}" install || die
}

pkg_postinst() {
	einfo "ISP plugin is now installed, please run it using !onplug isp or!plugin /usr/local/lib/libisp_pi.so"
	ewarn "Do NOT report bugs to Gentoo's bugzilla"
	einfo "Please report all bugs to http://forums.verlihubproject.org/viewforum.php?f=36"
	einfo "Verlihub-project team"
}
