# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 udev

DESCRIPTION="Adds loopback and LED control to headsets"
HOMEPAGE="https://github.com/Sapd/HeadsetControl"
SRC_URI=""
EGIT_REPO_URI="https://github.com/Sapd/HeadsetControl"

EGIT_COMMIT=""
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE="udev"

DEPEND="
	dev-build/cmake
	dev-libs/hidapi
	udev? ( virtual/udev )
"
RDEPEND="
	dev-libs/hidapi
"
BDEPEND=""

CMAKE_MAKEFILE_GENERATOR="emake"

src_prepare() {
	default
	sed -i "s;lib/udev/rules.d;$(get_udevdir)/rules.d;" "${WORKDIR}/${P}/CMakeLists.txt" || die "Failed to replace the udev rules location"
	cmake_src_prepare
}

src_install(){
	udev_newrules "${FILESDIR}/70-headsets.rules" 70-headsets.rules
}

pkg_postinst() {
	if use udev; then
		udev_reload
	fi
}