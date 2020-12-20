# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/pritunl/pritunl-client-electron/archive/${PV}.tar.gz -> pritunl-client-electron-${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

inherit eutils golang-build

src_unpack() {
	unpack pritunl-client-electron-${PV}.tar.gz
	mv ${WORKDIR}/pritunl-client-electron-${PV}/service ${S}
	pushd ${S}
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)"
	GOCACHE="${T}/go-cache"
	go get -d || die
}

src_prepare() {
	eapply_user
}

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -o "bin/pritunld" || die
}

src_install() {
	dobin bin/pritunld
	# install the init.d script
	newinitd "${FILESDIR}/pritunld.rc" pritunld
}
