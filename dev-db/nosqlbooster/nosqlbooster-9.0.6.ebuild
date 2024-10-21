

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

SRC_URI="https://s3.nosqlbooster.com/download/releasesv9/nosqlbooster4mongo-${PV}.tar.gz"

DESTDIR="/opt"

# src_unpack() {
#     unpack_deb ${A}
# }

# src_prepare(){
	
# 	# fix .desktop exec location
# 	# sed -i "/Exec/s:/usr/lib/pritunl_client_electron/Pritunl:${DESTDIR}/usr/lib/pritunl_client_electron/Pritunl:" \
# 	# 	${S}usr/share/applications/pritunl-client-electron.desktop ||
# 	# 	die "fixing of exec location on .desktop failed"

# 	default
# }

src_install() {
	# doicon -s 256 "usr/share/icons/hicolor/256x256/apps/pritunl_client_electron.png"
	# domenu "usr/share/applications/${PN}.desktop"

	insinto "${DESTDIR}"
	insopts -m0755
	doins -r .

	dosym ${DESTDIR}/nosqlbooster4mongo-${PV}/nosqlbooster4mongo /usr/bin/nosqlbooster4mongo

	default
}
