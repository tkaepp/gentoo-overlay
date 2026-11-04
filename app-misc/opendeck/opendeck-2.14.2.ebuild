# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop udev unpacker xdg

DESCRIPTION="Use stream controllers like the Elgato Stream Deck with Stream Deck SDK plugins"
HOMEPAGE="https://github.com/nekename/OpenDeck"
SRC_URI="https://github.com/nekename/OpenDeck/releases/download/v${PV}/${PN}_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libayatana-appindicator
	dev-libs/openssl:0/3
	media-libs/fontconfig
	net-libs/libsoup:3.0
	net-libs/webkit-gtk:4.1
	sys-apps/dbus
	virtual/libudev
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libxcb
	x11-libs/libxkbcommon
"

QA_PREBUILT="
	usr/bin/opendeck
	usr/lib/opendeck/plugins/*
"

src_install() {
	dobin usr/bin/opendeck

	# tauri resolves its resource dir to /usr/lib/<productName>, keep it there
	insinto /usr/lib/opendeck
	doins -r usr/lib/opendeck/plugins
	fperms 0755 /usr/lib/opendeck/plugins/com.amansprojects.starterpack.sdPlugin/x86_64-unknown-linux-gnu/bin/opendeck-starterpack

	domenu usr/share/applications/opendeck.desktop
	doicon -s 512 usr/share/icons/hicolor/512x512/apps/opendeck.png

	insinto /usr/share/metainfo
	doins usr/share/metainfo/opendeck.metainfo.xml

	udev_dorules etc/udev/rules.d/40-streamdeck.rules
}

pkg_postinst() {
	xdg_pkg_postinst
	udev_reload
}

pkg_postrm() {
	xdg_pkg_postrm
	udev_reload
}
