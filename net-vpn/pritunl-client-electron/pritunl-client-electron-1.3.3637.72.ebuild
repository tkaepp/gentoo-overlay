# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Gentoo Ebuild for the pritunl electron app and the background service"
HOMEPAGE="https://github.com/pritunl/pritunl-client-electron"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="net-libs/nodejs[npm]"
PYTHON_COMPAT=( python3_{11,12} )
inherit git-r3 unpacker
S="${WORKDIR}/"

SRC_URI="https://github.com/pritunl/${PN}/releases/download/${PV}/${PN}_${PV}-0ubuntu1.jammy_amd64.deb"

DESTDIR="/opt/${PN}"

src_unpack() {
    unpack_deb ${A}
}

src_install() {
	# exeinto ${DESTDIR}
	# doexe ${DESTDIR}/usr/lib/pritunl_client_electron/Pritunl

	insinto "${DESTDIR}"
	insopts -m0755
	doins -r .

	dosym ${DESTDIR}/usr/lib/pritunl_client_electron/Pritunl /usr/bin/pritunl-client-electron

	default
}
