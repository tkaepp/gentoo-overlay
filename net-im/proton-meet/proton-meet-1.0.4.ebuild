# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="ProtonMeet"

DESCRIPTION="Proton's official desktop application for Proton Meet"
HOMEPAGE="https://proton.me/meet"
SRC_URI="https://proton.me/download/meet/linux/${PV}/ProtonMeet-desktop.deb"

SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch mirror strip bindist"

BDEPEND="app-arch/dpkg"

S="${WORKDIR}"

QA_PREBUILT="usr/lib/proton-meet/*"

pkg_nofetch() {
	elog "Please download the Proton Meet .deb file from:"
	elog "  https://proton.me/meet"
	elog "and place it in your distfiles directory as:"
	elog "  ${DISTDIR}/${MY_PN}-desktop.deb"
}

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	insinto /usr
	doins -r usr/*

    fperms +x /usr/lib/proton-meet/Proton\ Meet\ Beta

	# Chrome-sandbox requires the setuid bit to be specifically set.
    # see https://github.com/electron/electron/issues/17972
#     fowners root "/usr/lib/${PN}/chrome-sandbox"
#     fperms 4711 "/usr/lib/${PN}/chrome-sandbox"

    doexe /usr/lib/${PN}/Proton\ Meet\ Beta
    doexe /usr/lib/${PN}/chrome-sandbox
    doexe /usr/bin/${PN}
#
#     exeinto "/usr/bin"
#     newexe "${T}/launcher.sh" "discord" || die "failing to install launcher"
#
# 	# Make the binary executable
# 	fperms +x /usr/bin/proton-meet
# 	fperms +x /usr/lib/proton-meet/proton-meet
# 	fperms +x /usr/lib/proton-meet/chrome-sandbox
}
