# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Gentoo Ebuild for the pritunl cli"
HOMEPAGE="https://github.com/pritunl/pritunl-client-electron"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="net-vpn/pritunl-client-electron"
RDEPEND="${DEPEND}"
BDEPEND=""
PYTHON_COMPAT=( python3_{11,12} )
inherit go-module git-r3 distutils-r1

# for golang-build
EGO_PN=github.com/pritunl/pritunl-client-electron/cli
EGIT_REPO_URI="https://github.com/tkaepp/pritunld.git"

src_compile() {
	go build -C cli -v -o bin/pritunld || die
}

src_install() {
	dobin cli/bin/pritunld
}
