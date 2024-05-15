# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 udev desktop

DESCRIPTION="A service, Web Interface, and UI for using a Stream Deck"
HOMEPAGE="https://github.com/streamdeck-linux-gui/streamdeck-linux-gui"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/streamdeck-linux-gui/streamdeck-linux-gui.git"
else
	SRC_URI="https://github.com/streamdeck-linux-gui/streamdeck-linux-gui/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/streamdeck-linux-gui-${PV}"
fi

LICENSE="MIT Apache-2.0"
SLOT="0"
IUSE=""

RESTRICT="test"

DEPEND="virtual/udev
		${PYTHON_DEPS}
		dev-python/importlib-metadata[${PYTHON_USEDEP}]
		dev-python/filetype[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/evdev[${PYTHON_USEDEP}]
		dev-python/pyside6[${PYTHON_USEDEP}]
		dev-python/python-xlib[${PYTHON_USEDEP}]
		media-gfx/cairosvg[${PYTHON_USEDEP}]
		media-libs/elgato-streamdeck[${PYTHON_USEDEP}]
		"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest

src_prepare() {
	sed -i "s#os.path.dirname(os.path.abspath(__file__))#'/usr/share/streamdeck-ui'#" streamdeck_ui/config.py
	distutils-r1_src_prepare
}

src_install() {
	udev_newrules udev/60-streamdeck.rules 60-streamdeck.rules

	make_desktop_entry ${PN} "Streamdeck GUI App" streamdeck "Video" 
	
	newinitd "${FILESDIR}/streamdeck.rc" streamdeck

	

	insinto /usr/share/streamdeck-ui
	doins streamdeck_ui/logo.png
	doins -r streamdeck_ui/fonts
	distutils-r1_src_install
}


pkg_postinst() {
        udev_reload
}

pkg_postrm() {
        udev_reload
}