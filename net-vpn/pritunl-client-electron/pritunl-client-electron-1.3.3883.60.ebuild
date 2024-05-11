# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Gentoo Ebuild for the pritunl electron app and the background service"
HOMEPAGE="https://github.com/pritunl/pritunl-client-electron"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="net-vpn/pritunl-client-electron-service"
RDEPEND="${DEPEND}"
BDEPEND=""
inherit unpacker desktop
S="${WORKDIR}/"

SRC_URI="https://github.com/pritunl/${PN}/releases/download/${PV}/${PN}_${PV}-0ubuntu1.mantic_amd64.deb"

DESTDIR="/opt/${PN}"

src_unpack() {
    unpack_deb ${A}
}

src_prepare(){
	
	# fix .desktop exec location
	sed -i "/Exec/s:/usr/lib/pritunl_client_electron/Pritunl:${DESTDIR}/usr/lib/pritunl_client_electron/Pritunl:" \
		${S}usr/share/applications/pritunl-client-electron.desktop ||
		die "fixing of exec location on .desktop failed"

	default
}

pkg_preinst(){
	# remove the /usr/bin binaries from the deb. symlinking the electron app directly into the /opt
	# cli and service binaries are installed from source through th packages in DEPEND
	rm -r ${DESTDIR}/usr/bin
}

src_install() {
	doicon -s 256 "usr/share/icons/hicolor/256x256/apps/pritunl_client_electron.png"
	domenu "usr/share/applications/${PN}.desktop"

	insinto "${DESTDIR}"
	insopts -m0755
	doins -r .

	dosym ${DESTDIR}/usr/lib/pritunl_client_electron/Pritunl /usr/bin/pritunl-client-electron

	default
}
