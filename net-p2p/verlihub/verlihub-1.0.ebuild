# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils

DESCRIPTION="VerliHub is a Direct Connect protocol server (Hub)"
HOMEPAGE="http://www.verlihub-project.org"
SRC_URI="mirror://sourceforge/verlihub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="
	+chatroom
	+forbid
	+iplog
	isp
	+lua
	messanger
	+python
	stats
	+replacer
"

DEPEND="dev-util/cmake
	>=dev-db/mysql-5.0
	dev-libs/openssl
	dev-libs/libpcre
	dev-libs/geoip
	sys-libs/zlib
	sys-devel/gettext
	lua? ( >=dev-lang/lua-5.1 )
	python? ( >=dev-lang/python-2.5 )"

RDEPEND="${DEPEND}
	dev-util/dialog"

S="${WORKDIR}/${PN}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with chatroom)
		$(cmake-utils_use_with forbid)
		$(cmake-utils_use_with iplog)
		$(cmake-utils_use_with isp)
		$(cmake-utils_use_with messanger)
		$(cmake-utils_use_with python)
		$(cmake-utils_use_with replacer)
		$(cmake-utils_use_with stats)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# Install init and conf files
	newinitd "${FILESDIR}"/"${PN}".init "${PN}"
	newconfd "${FILESDIR}"/"${PN}".conf "${PN}"
}

pkg_postinst() {
	einfo "You are now ready to use VerliHub into your system."
	einfo "Do NOT report bugs to Gentoo's bugzilla"
	einfo "Please report all bugs to http://www.verlihub-project.org/bugs"
	einfo
	einfo "Now you could use Gentoo deamon editing config file in"
	einfo "/etc/conf.d/. Then start verlihub daemon using"
	einfo "/etc/init.d/verlihub start"
	einfo
	einfo "If you need help you can read the manual at "
	einfo "http://www.verlihub-project.org/manual or ask on forum at"
	einfo "http://www.verlihub-project.org/discussions"
	einfo

	ewarn "You need to configure verlihub before starting it:"
	ewarn "emerge --config =${CATEGORY}/${PF}"
	ewarn "If you alread do tht please skip this step."
	ewarn
	ewarn "If you are updating verlihub from version < 1.0 you need"
	ewarn "to run migration script for each of your installed hubs:"
	ewarn "vh_migration_0.9.8eto1.0"
	ewarn "Please follow the instructions in the script"
	ewarn
}

pkg_config() {
	einfo "Starting vh_manage"
	sleep 2
	/usr/bin/vh_manage
}
