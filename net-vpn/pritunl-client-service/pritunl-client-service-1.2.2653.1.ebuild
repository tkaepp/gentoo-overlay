# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/pritunl/pritunl-client-electron/archive/${PV}.tar.gz -> pritunl-client-electron-${PV}.tar.gz"

inherit eutils golang-build golang-vcs

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

EGO_PN="github.com/dropbox/godropbox/errors
	github.com/gin-gonic/gin
	github.com/pritunl/pritunl-client-electron/service/auth
	github.com/pritunl/pritunl-client-electron/service/autoclean
	github.com/pritunl/pritunl-client-electron/service/constants
	github.com/pritunl/pritunl-client-electron/service/errortypes
	github.com/pritunl/pritunl-client-electron/service/handlers
	github.com/pritunl/pritunl-client-electron/service/logger
	github.com/pritunl/pritunl-client-electron/service/profile
	github.com/pritunl/pritunl-client-electron/service/utils
	github.com/pritunl/pritunl-client-electron/service/watch
	github.com/sirupsen/logrus"

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
