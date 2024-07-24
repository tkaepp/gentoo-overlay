# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{11..12} )
inherit python-r1 udev desktop

DESCRIPTION=" An elegant Linux app for the Elgato Stream Deck with support for plugins "
HOMEPAGE="https://github.com/StreamController/StreamController"

PV=
SRC_URI="https://github.com/StreamController/StreamController/archive/refs/tags/1.5.0-beta.6.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
S="${WORKDIR}/StreamController-1.5.0-beta.6"


LICENSE="MIT Apache-2.0"
SLOT="0"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

RDEPEND="virtual/udev
		${PYTHON_DEPS}
		dev-python/setproctitle[${PYTHON_USEDEP}]
		dev-python/importlib-metadata[${PYTHON_USEDEP}]
		dev-python/filetype[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/evdev[${PYTHON_USEDEP}]
		dev-python/pyside6[${PYTHON_USEDEP}]
		dev-python/python-xlib[${PYTHON_USEDEP}]
		media-gfx/cairosvg[${PYTHON_USEDEP}]
		media-libs/elgato-streamdeck[${PYTHON_USEDEP}]
		"
DEPEND="${RDEPEND}"

# src_prepare() {
# 	sed -i "s#os.path.dirname(os.path.abspath(__file__))#'/usr/share/streamdeck-ui'#" streamdeck_ui/config.py
# 	distutils-r1_src_prepare
# }

src_install() {
	udev_newrules udev.rules 60-streamcontroller.rules

	make_desktop_entry ${PN} "Streamcontroller" streamcontroller "Video" 
	
	# newinitd "${FILESDIR}/streamdeck.rc" streamdeck


	insinto /usr/share/streamcontroller
	# doins streamcontroller/logo.png
	# doins -r streamcontroller/fonts
	distutils-r1_src_install
}


pkg_postinst() {
        udev_reload
}

pkg_postrm() {
        udev_reload
}