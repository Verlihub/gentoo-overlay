# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Verlihub, a linux hub for the p2p program 'direct connect'"
HOMEPAGE="http://www.verlihub-project.org"
SRC_URI="mirror://sourceforge/verlihub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 x86-fbsd"
IUSE="lua iplog forbid messanger chatroom isp replacer stats python"

DEPEND="dev-libs/libpcre
	dev-libs/geoip
	>=dev-db/mysql-5.0
	sys-libs/zlib"

PDEPEND="lua? ( net-libs/lua )
	iplog? ( net-libs/iplog )
	forbid? ( net-libs/forbid )
	messanger? ( net-libs/messanger )
	chatroom? ( net-libs/chatroom )
	isp? ( net-libs/isp )
	replacer? ( net-libs/replacer )
	stats? ( net-libs/stats )
	python? ( net-libs/python )"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"
}
src_compile() {
        econf || die "Config failed; please report problems or bugs to http://forums.verlihub-project.org/viewforum.php?f=36"
        emake || die "Make failed; please report problems or bugs to http://forums.verlihub-project.org/viewforum.php?f=36"
}

src_install() {
        make DESTDIR=${D} install || die

        docinto "scripts"
        dodoc \
                #scripts/ccgraph \
                #scripts/import_reglist_0.9.x_to_0.9.8b.sql  \
                #scripts/install \
                #scripts/regnick \
                #scripts/runhub  \
                #scripts/setenv  \
                #scripts/trigger \
                scripts/vh_runhub.in

        docinto ""
        dodoc \
                AUTHORS \
                COPYING \
                ChangeLog \
                INSTALL \
                NEWS \
                README \
                TODO \
               # docs/configuring.txt \
               # docs/help \
               # docs/help.sql \
               # docs/ascii \
               # docs/params.php \
               # docs/using.txt
}

pkg_postinst() {
    echo
    ewarn "Do NOT report bugs to Gentoo's bugzilla"
    einfo "Please report all bugs to Verlihub forums at http://forums.verlihubproject.org/viewforum.php?f=36"
    einfo "Verlihub Project Team"

    if [[ -f "/etc/verlihub/dbconfig" ]]
    then
	einfo "Verlihub is already configured in /etc/verlihub"
	einfo "You can configure a new hub by typing:"
	ewarn "emerge --config =${CATEGORY}/${PF}"
    else
	ewarn "You MUST configure verlihub before starting it:"
	ewarn "emerge --config =${CATEGORY}/${PF}"
	ewarn "That way you can [re]configure your verlihub setup"
    fi
}

pkg_config() {
    ewarn "Configuring verlihub"
    /usr/bin/vh_install
    if [[ $? ]]
    then
    	ewarn "You have not configured verlihub succesfully. Please try again"
    else
        ewarn "Configuration completed"
    fi
}

