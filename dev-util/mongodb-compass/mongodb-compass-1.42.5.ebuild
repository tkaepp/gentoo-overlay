EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="The GUI for MongoDB"
HOMEPAGE="https://mongodb.com/compass https://github.com/mongodb-js/compass"
SRC_URI="https://github.com/mongodb-js/compass/releases/download/v${PV}/mongodb-compass_${PV}_amd64.deb -> mongodb-compass_${PV}_amd64.deb"

LICENSE="SSPL"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	default

	insinto /usr/lib/mongodb-compass
	doins -r usr/lib/mongodb-compass/.

	domenu usr/share/applications/mongodb-compass.desktop
	doicon usr/share/pixmaps/mongodb-compass.png

	fperms +x "/usr/lib/mongodb-compass/MongoDB Compass"
	fperms 4755 /usr/lib/mongodb-compass/chrome-sandbox || die

	# Included binary doesn't work, make a symlink instead
	rm usr/bin/mongodb-compass
	dosym "../lib/mongodb-compass/MongoDB Compass" "usr/bin/mongodb-compass"
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
