# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module
DESCRIPTION="Tool to show alerts for datadog on my waybar"
HOMEPAGE="https://github.com/tkaepp/waybar-datadog"

# for golang-build
SRC_URI="https://pkgs.tkae.internal/gentoo/app-misc/waybar-datadog/${P}.tar.gz"
SRC_URI+=" https://pkgs.tkae.internal/gentoo/app-misc/waybar-datadog/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.25.5"

src_compile() {
  ego build
}

src_install() {
    dobin waybar-datadog

    default
}
