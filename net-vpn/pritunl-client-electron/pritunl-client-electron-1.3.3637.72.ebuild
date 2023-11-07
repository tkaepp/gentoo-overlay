# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Gentoo Ebuild for the pritunl electron app and the background service"
HOMEPAGE="https://github.com/pritunl/pritunl-client-electron"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="net-vpn/pritunl-client-electron-service
		net-vpn/pritunl-client-electron-cli"
RDEPEND="${DEPEND}"
BDEPEND=""
inherit unpacker
S="${WORKDIR}/"

SRC_URI="https://github.com/pritunl/${PN}/releases/download/${PV}/${PN}_${PV}-0ubuntu1.jammy_amd64.deb"

DESTDIR="/opt/${PN}"

src_unpack() {
    unpack_deb ${A}
}

pkg_preinst(){
	# remove the /usr/bin binaries from the deb. symlinking the electron app directly into the /opt
	# cli and service binaries are installed from source through th packages in DEPEND
	rm -r ${DESTDIR}/usr/bin
}

src_install() {
	insinto "${DESTDIR}"
	insopts -m0755
	doins -r .

	dosym ${DESTDIR}/usr/lib/pritunl_client_electron/Pritunl /usr/bin/pritunl-client-electron

	default
}
